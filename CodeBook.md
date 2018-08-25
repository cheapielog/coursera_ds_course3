## Coursera / John Hopkins Data Science Specialization - Course 3 - Course Project

### CodeBook.md

From the working directory (root folder), executing the R script "run_analysis.R" performs the following:

Step 1) Combine train and test datasets  
* Read in the 3 train datasets from "/UCI HAR Dataset/train/" ("subject_train.txt", "X_train.txt", "y_train.txt"). (Note: "subject" contains subject IDs, "X" are the actual measurements and "y" contains the activity labels.)
* Horizontally combines the 3 files into 1 single train dataset in the order "subject" -> "y" -> X".
* Read in the 3 test datasets from "/UCI HAR Dataset/test/" ("subject_test.txt", "X_test.txt", "y_test.txt").
* Combine the 3 files into 1 single test dataset in the order "subject" -> "y" -> X".
* Combine the single train dataset and single test dataset into 1 gigantic dataset.
* Assign correct column names to the "merged" dataset (col1 is "SubjectID", col2 is "Activity", col3 to col563 names are extracted from the original "features.txt").

Step 2) Extract mean and standard deviation of measurements from the "merged" dataset
* Locate the column IDs that contains the strings "mean()" and "std()". Note that some columns may only be utilizing mean and standard deviation values for calculations but they are not actual mean and standard deviation measurements. (e.g.: Column with name "fBodyBodyAccJerkMag-mean[Name: Freq()"). These columns have not been extracted for additional analysis.
* Extract the correct columns (based on column IDs obtained from previous step) and place those into a new dataset

Step 3) Replace all the activities with descriptive names
* The dataset from Step 2) above contains values 1-6 for the "Activity" column.
* According to the original "activity_labels.txt", the "Activity" column values are updated. 

Step 4) Clean up column labels 
* Due to the "length" of the individual column labels (many of them with multiple words), these labels have not been converted to all lower cases for readability purposes.
* This being said, the abbreviations have been removed. ("t" - "[Name: TimeDomain", "f" - "[Name: FrequencyDomain", "Acc" - "Accelerometer", "Gyro" - "Gyroscope").
* The "-" separating mean() / std() from the axial labels (X / Y / Z) have been retained as well.

Step 5) Create the actual "result.txt" output
* Group the dataset from step 4) based on i) SelectionID column (values: 1-30) and ii) for each unique value of the SelectionID column, group according to the 6 unique values in the Activity column.
* For each sub-group from the last step (30 subjects x 6 activities = 180 sub-groups), calculate the average of the rest of the measurement variables. 
* Output the results to the "result.txt" file (180 rows and 68 columns).

A description of the variables (columns) in "result.txt" file:

Columns 1 and 2 -
[Name: SubjectID]: Class integer; Subject IDs with integer values ranging from 1 to 30.
[Name: Activity]: Class char; 6 types of activities -
* laying
* sitting
* standing
* walking
* walking upstairs
* walking downstairs

The rest of the columns (Columns 3 to Columns 68) are of class numeric and they represent average values calculated from the original data for a particular activity for a particular subject.
* [Name: TimeDomainBodyAccelerometer-mean()-X]
* [Name: TimeDomainBodyAccelerometer-mean()-Y]
* [Name: TimeDomainBodyAccelerometer-mean()-Z]
* [Name: TimeDomainBodyAccelerometer-std()-X]
* [Name: TimeDomainBodyAccelerometer-std()-Y]
* [Name: TimeDomainBodyAccelerometer-std()-Z]
* [Name: TimeDomainGravityAccelerometer-mean()-X]
* [Name: TimeDomainGravityAccelerometer-mean()-Y]
* [Name: TimeDomainGravityAccelerometer-mean()-Z]
* [Name: TimeDomainGravityAccelerometer-std()-X]
* [Name: TimeDomainGravityAccelerometer-std()-Y]
* [Name: TimeDomainGravityAccelerometer-std()-Z]
* [Name: TimeDomainBodyAccelerometerJerk-mean()-X]
* [Name: TimeDomainBodyAccelerometerJerk-mean()-Y]
* [Name: TimeDomainBodyAccelerometerJerk-mean()-Z]
* [Name: TimeDomainBodyAccelerometerJerk-std()-X]
* [Name: TimeDomainBodyAccelerometerJerk-std()-Y]
* [Name: TimeDomainBodyAccelerometerJerk-std()-Z]
* [Name: TimeDomainBodyGyroscope-mean()-X]
* [Name: TimeDomainBodyGyroscope-mean()-Y]
* [Name: TimeDomainBodyGyroscope-mean()-Z]
* [Name: TimeDomainBodyGyroscope-std()-X]
* [Name: TimeDomainBodyGyroscope-std()-Y]
* [Name: TimeDomainBodyGyroscope-std()-Z]
* [Name: TimeDomainBodyGyroscopeJerk-mean()-X]
* [Name: TimeDomainBodyGyroscopeJerk-mean()-Y]
* [Name: TimeDomainBodyGyroscopeJerk-mean()-Z]
* [Name: TimeDomainBodyGyroscopeJerk-std()-X]
* [Name: TimeDomainBodyGyroscopeJerk-std()-Y]
* [Name: TimeDomainBodyGyroscopeJerk-std()-Z]
* [Name: TimeDomainBodyAccelerometerMag-mean()]
* [Name: TimeDomainBodyAccelerometerMag-std()]
* [Name: TimeDomainGravityAccelerometerMag-mean()]
* [Name: TimeDomainGravityAccelerometerMag-std()]
* [Name: TimeDomainBodyAccelerometerJerkMag-mean()]
* [Name: TimeDomainBodyAccelerometerJerkMag-std()]
* [Name: TimeDomainBodyGyroscopeMag-mean()]
* [Name: TimeDomainBodyGyroscopeMag-std()]
* [Name: TimeDomainBodyGyroscopeJerkMag-mean()]
* [Name: TimeDomainBodyGyroscopeJerkMag-std()]
* [Name: FrequencyDomainBodyAccelerometer-mean()-X]
* [Name: FrequencyDomainBodyAccelerometer-mean()-Y]
* [Name: FrequencyDomainBodyAccelerometer-mean()-Z]
* [Name: FrequencyDomainBodyAccelerometer-std()-X]
* [Name: FrequencyDomainBodyAccelerometer-std()-Y]
* [Name: FrequencyDomainBodyAccelerometer-std()-Z]
* [Name: FrequencyDomainBodyAccelerometerJerk-mean()-X]
* [Name: FrequencyDomainBodyAccelerometerJerk-mean()-Y]
* [Name: FrequencyDomainBodyAccelerometerJerk-mean()-Z]
* [Name: FrequencyDomainBodyAccelerometerJerk-std()-X]
* [Name: FrequencyDomainBodyAccelerometerJerk-std()-Y]
* [Name: FrequencyDomainBodyAccelerometerJerk-std()-Z]
* [Name: FrequencyDomainBodyGyroscope-mean()-X]
* [Name: FrequencyDomainBodyGyroscope-mean()-Y]
* [Name: FrequencyDomainBodyGyroscope-mean()-Z]
* [Name: FrequencyDomainBodyGyroscope-std()-X]
* [Name: FrequencyDomainBodyGyroscope-std()-Y]
* [Name: FrequencyDomainBodyGyroscope-std()-Z]
* [Name: FrequencyDomainBodyAccelerometerMag-mean()]
* [Name: FrequencyDomainBodyAccelerometerMag-std()]
* [Name: FrequencyDomainBodyBodyAccelerometerJerkMag-mean()]
* [Name: FrequencyDomainBodyBodyAccelerometerJerkMag-std()]
* [Name: FrequencyDomainBodyBodyGyroscopeMag-mean()]
* [Name: FrequencyDomainBodyBodyGyroscopeMag-std()]
* [Name: FrequencyDomainBodyBodyGyroscopeJerkMag-mean()]
* [Name: FrequencyDomainBodyBodyGyroscopeJerkMag-std()]