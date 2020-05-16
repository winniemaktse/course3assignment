# course3assignment
Coursera Data Science Course 3 - Getting and Cleaning Data Assignment

Overview
run_analysis performs the 5 following steps as required in the course assignment:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


Details
Before all, it reads files from the folder created by the raw zipped data file and create 7 data frames. 
- X_test: The measurement values of testing data from test/X_test.txt
- y_test: The activity values of testing data from test/y_test.txt
- sub_test: The subject IDs of testing data from test/subject_test.txt
- X_train: The measurement values of training data from train/X_train.txt
- y_train: The activity values of training data from train/y_train.txt
- sub_train: The subject IDs of training data from train/subject_train.txt
- feature: The list of all features (total 561)

1. Merges the training and the test sets
The training and testing sets were combined with rbind to create 3 data frames for the measurement values X, activity values y and the subject IDs sub.

2. Extracts only the measurements on the mean and standard deviation for each measurement
The feature data frame that contains either mean or std were filtered with grep so it could be used to extract useful data columns in X data frame using select.

3. Uses descriptive activity names to name the activities in the data set. 
The descriptive activity names were found in activity_labels.txt. mapvalues function was used to replace integar 1:6 to its corresponding activity names.

4. Appropriately labels the data set with descriptive variable names.
The 3 data frames were first combined using cbind. The descriptive variable names were found in features.txt and the filtered feature data frame (in step 2), together with "subject" and "activities" were using to label the name of the combined data set.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Finally, the group_by and summarise_all functions in the dplyr package were used to group each activity and each subject, and compute the average of the rest of the variable.
