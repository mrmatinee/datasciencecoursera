## List all the files in the working directory (in my case "Project Data")
allfiles <- list.files(, recursive=TRUE)
## print list of files to catalog what's in the working directory
allfiles

    ## READ RAW FILES INTO R

## Read activity data for training & test sets
y.test  <- read.table("y_test.txt", quote = "\"'")
y.train <- read.table("y_train.txt", quote = "\"'")
x.test <- read.table("X_test.txt", quote = "\"'")
x.train <- read.table("X_train.txt", quote = "\"'")

## Read the subject files for training & test sets
subjectdata.test <- read.table("subject_test.txt", quote = "\"'")
subjectdata.train <- read.table("subject_train.txt", quote = "\"'")

## Read the features & labels files
features <- read.table("features.txt", quote = "\"'")
labels<-read.table("activity_labels.txt", quote = "\"'")

## Join train and test files together in each category.
subjects <- rbind(subjectdata.train, subjectdata.test)
activities <- rbind(y.train,y.test)
readings <- rbind(x.train,x.test)

## Set unique number of subjects & labels using plyr package
library(plyr)
tmp <- count(unique(subjects)); subjectNum <- sum(tmp$freq)
tmp <- count(unique(labels)); labelNum <- sum(tmp$freq)

## Remove working files--no longer necessary.
rm(subjectdata.train,subjectdata.test,y.train,y.test,x.train,x.test, tmp)

## Decode activity label and put result in new activity name column.
activities$activityName <- labels[activities$V1,2]

## Clean up feature names & assign to readings data columns
cleanFeatures <- gsub("([()])", "", features[,2])
cleanFeatures <- gsub("([-])","",cleanFeatures)
cleanFeatures <- gsub("([,])","",cleanFeatures)

colnames(readings) <- cleanFeatures

## Join columns to create master file--rename columns.
master <- cbind(activities,subjects)
colnames(master) <- c("activityLabel","activityName","activitySubject")
master <- cbind(master,readings[,41:46],readings[,214:215],readings[,253:254],
              readings[,266:271],readings[,345:350],readings[,424:429],
              readings[,503:504],readings[,516:517],
              readings[,529:530],readings[,542:543])

## Remove working files again
rm(subjects,activities,readings,features,cleanFeatures)

## Sort the master file
master <- master[order(master$activitySubject,desc(master$activityLabel)),]

## Initialize return matrix for processing.
## Create matrix of dimensions required by number of labels & subjects
output <- matrix(NA,labelNum*subjectNum,length(master))
## Transform the matrix into a data frame
output <- as.data.frame(output)
##  Assign names to variables
colnames(output) <- names(master)

outputCtr <- 1
## Couldn't find an easy way to melt/dcast or data.table/.SD given the
## 70 means to be returned. So, looping through manually.
for(i in 1:labelNum){
  tmpAct <- master[master$activityLabel == i,]
  for(j in 1:subjectNum){
    tmpActSubj <- tmpAct[tmpAct$activitySubject==j,]
    output[outputCtr,1] <- i
    output[outputCtr,2] <- as.character(labels[i,2])
    output[outputCtr,3] <- j
    for(k in 1:(length(master)-3)){
      output[outputCtr,k+3] <- mean(tmpActSubj[,k+3])
    }
    outputCtr <- outputCtr+1
  }
}

## Save the output files.
write.table(master, "masterdata.txt", row.names=TRUE, col.names=TRUE) 
write.table(output, "activitysubjectmeans.txt", row.names=TRUE, col.names=TRUE) 
listOfVariables <- data.frame(names(output))

##Write the output file
write.csv(listOfVariables, "listOfVariables.csv")

## Remove working files.
rm(tmpAct, tmpActSubj, labels, listOfVariables)
rm(master, output, i, j, k, labelNum, outputCtr, subjectNum, allfiles)

## Reset working directory
setwd("../")
