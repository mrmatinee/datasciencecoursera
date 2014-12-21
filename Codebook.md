Getting and Cleaning Data Assignment

--Tidy Data Set--Motion Studies using Smartphone Data

The original experiments were performed by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, and Luca Oneto at the Smartlab - Non Linear Complex Systems Laboratory, UniversitÃ  degli Studi di Genova, Italy. 

The files include training and separate file sets for accelerometer and gyroscope recordings for the X, Y, and Z axes, a list of all features included in the data set, labels for activities that also link the numeric codes with the activity name, and specific labels for the data in each file above.


utputCtr <- 1
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




The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

THE TIDY DATA SET

The first three columns identify the activity by number (column 1) and name (column 2) and the subject who carried out the activity (column three).

The remaining columns provide means for the variable named in the column head.  These follow naming conventions from the original data set:

Accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. The acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using a low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.  Note the X, Y, & Z readings appear in separate columns in the tidy data set.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean


For more information about this dataset contact: activityrecognition@smartlab.ws
