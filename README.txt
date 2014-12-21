==================================================================
Human Activity Recognition Using Smartphones Dataset

ORIGINAL DATA
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================


A group of 30 volunteers from ages 19-48 years each performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. The embedded accelerometer and gyroscope captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 

The original dataset had been randomly partitioned into two sets where 70% of the volunteers were selected for generating the training data and 30% the test data.  

PROCESS FOR PRODUCING A TIDY DATA SET

First:  Read raw activity data from both training and test sets into R as working files.  Read raw data designating the experiment subjects, labels, and data variables into R as working files.

Second:  Join the training and test sets of data together in each category using "rbind."  This produces three working files: experiment subjects, activities performed, and the readings for each activity.

Third:  Store the unique number of subjects and labels for later use in creating the data matrix.  After this step it's possible to remove the raw working files to save memory and keep things tidy in R Studio.

Fourth:  Decode the numerical activity labels and assign human readable names in a new activity name column.  Note:  I have perserved the numbers as well in the output file to verify that labels are correctly assigned.  At this point I also clean up some of the names, though I preserve the names for variables almost exactly, as they will be familiar to anyone who eventually uses the tidy data set.  Of course, if requested I could assign more intuitive variable names as well.

Fifth:  Bind columns of activity names, subjects, and data readings to create a master file.  Assign column labels.  At this point it's possible to remove some working files again.

Sixth:  Sort the master file by subject and activity.  Initialize a matrix and transform the matrix into a data frame with variable names assigned to the column head.

Seventh:  Using a for loop, return the means for the variables and place them in the correct rows and columns.

Eighth:  Write the output files using "write.table." 
