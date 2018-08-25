# Coursera / John Hopkins Data Science Specialization - Course 3 - Course Project

# 1) Merges the training and the test sets to create one data set.

# a) Combine all "training" set data from txt files in "./train" folder
train_inertial_url <- "./UCI HAR Dataset/train/Inertial Signals/"
train_url <- "./UCI HAR Dataset/train/"
# train_IS_body_acc_x <- read.table(paste0(train_inertial_url,"body_acc_x_train.txt"), header=FALSE)
# train_IS_body_acc_y <- read.table(paste0(train_inertial_url,"body_acc_y_train.txt"), header=FALSE)
# train_IS_body_acc_z <- read.table(paste0(train_inertial_url,"body_acc_z_train.txt"), header=FALSE)
# train_IS_body_gyro_x <- read.table(paste0(train_inertial_url,"body_gyro_x_train.txt"), header=FALSE)
# train_IS_body_gyro_y <- read.table(paste0(train_inertial_url,"body_gyro_y_train.txt"), header=FALSE)
# train_IS_body_gyro_z <- read.table(paste0(train_inertial_url,"body_gyro_z_train.txt"), header=FALSE)
# train_IS_total_acc_x <- read.table(paste0(train_inertial_url,"total_acc_x_train.txt"), header=FALSE)
# train_IS_total_acc_y <- read.table(paste0(train_inertial_url,"total_acc_y_train.txt"), header=FALSE)
# train_IS_total_acc_z <- read.table(paste0(train_inertial_url,"total_acc_z_train.txt"), header=FALSE)
train_sub <- read.table(paste0(train_url,"subject_train.txt"), header=FALSE)
train_X <- read.table(paste0(train_url,"X_train.txt"), header=FALSE)
train_Y <- read.table(paste0(train_url,"Y_train.txt"), header=FALSE)
train_merged <- cbind(train_sub, train_Y, train_X)

# b) Combine all "test" set data in "./test" folder
test_url <- "./UCI HAR Dataset/test/"
test_sub <- read.table(paste0(test_url,"subject_test.txt"), header=FALSE)
test_X <- read.table(paste0(test_url,"X_test.txt"), header=FALSE)
test_Y <- read.table(paste0(test_url,"Y_test.txt"), header=FALSE)
test_merged <- cbind(test_sub, test_Y, test_X)

# c) Combine both "training" and "test" data from a) and b)
merged <- rbind(train_merged, test_merged)

# d) Fetch column names to data from c)
# Read "features.txt"
# Resulting 2nd column would be column names for cols (3 to 563) in data from c)
column_names <- read.table("./UCI HAR Dataset/features.txt", head=FALSE, stringsAsFactors=FALSE)
column_names <- column_names[,2]
# Update column names vector to include cols (1 to 2) for the subject id and the activity
column_names <- c("SubjectID", "Activity", column_names)
# Update column names for data from c)
colnames(merged) <- column_names

# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
# Find column names that contain "mean" or "std"
mean_std_cols <- c(1, 2, grep("[mM][eE][aA][nN]\\(\\)|[sS][tT][dD]\\(\\)",names(merged)))
# Do not forget to include cols 1 and 2 for subject id and activity
merged2 <- merged[, mean_std_cols]

# 3) Uses descriptive activity names to name the activities in the data set
# Update col 2 (activity) as follows:
# 1 - walking, 2 - walking upstairs, 3 - walking downstairs
# 4 - sitting, 5 - standing, 6 - laying
merged2$Activity <- gsub("1", "walking", merged2$Activity)
merged2$Activity <- gsub("2", "walking upstairs", merged2$Activity)
merged2$Activity <- gsub("3", "walking downstairs", merged2$Activity)
merged2$Activity <- gsub("4", "sitting", merged2$Activity)
merged2$Activity <- gsub("5", "standing", merged2$Activity)
merged2$Activity <- gsub("6", "laying", merged2$Activity)

# 4) Appropriately labels the data set with descriptive variable names.
# For these variable names, due to the length of each variable (which can be long with many
# words), it may be easier to capitalize individual words and keep "-" to separate mean / std
# and also the axial info (X, Y, Z)
column_names4 <- names(merged2)
# For column names starting with "t", replace with "TimeDomain"
column_names4 <- gsub("^t","TimeDomain",column_names4)
# For column names starting with "f", replace with "FrequencyDomain"
column_names4 <- gsub("^f","FrequencyDomain",column_names4)
# For column names with "Acc", replace with "Accelerometer"
column_names4 <- gsub("Acc","Accelerometer",column_names4)
# For column names with "Gyro", replace with "Gyroscope"
column_names4 <- gsub("Gyro","Gyroscope",column_names4)
# Update column names
colnames(merged2) <- column_names4

# 5) From the data set in step 4, creates a second, independent tidy data set with the average
# of each variable for each activity and each subject.
# Use: write.table() with row.name=FALSE
output <- merged2 %>% group_by(SubjectID, Activity) %>% summarise_all(mean)
# Output result to txt file
write.table(output, file="result.txt", row.name=FALSE)



