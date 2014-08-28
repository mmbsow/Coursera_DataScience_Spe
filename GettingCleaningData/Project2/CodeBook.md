# Getting and Cleaning Data - Course Project 2
## Code Book

=========
### Introduction:
This Code Book describes the "run_analysis.R" script which merges the train and test sets of the "UCI HAR Datasets" into a single data frame and, produces a tidy data set with the average of the mean and standard variation variables by subject and activity for each measurement.

*(Note: the below assumes that the working directory is the folder "UCI HAR Dataset", so all file paths are given in a relative form.)*

=========
### Pre-requisites:
The following files must be available to run the analysis script:

- "train/X_train.txt": Training set.
- "train/y_train.txt": Training labels.
- "train/subject_train.txt": Each row identifies the subject who performed the activity in the train sample - its range is from 1 to 30.
- "test/X_test.txt": Test set.
- "test/y_test.txt": Test labels.
- "test/subject_test.txt": Each row identifies the subject who performed the activity in the test sample - its range is from 1 to 30.
- "features.txt": List of all features.
- "activity_labels.txt": Links the class labels with their activity name.

==========

### Transformation:
In this section, we describe the transformations performed on the data.<br>

1. The training and test sets were merged to create a single data set by applying the following steps (in the listed order) to the differents data sets:

	- Load the X train set from "train/X_train.txt" into 'Xtrain' data frame
	- Load the y train set from "train/y_train.txt" into 'ytrain' data frame
	- Load the subject train set from "train/subject_train.txt" into 'strain' data frame
	- Load the X test set from "test/X_test.txt" into 'Xtest' data frame
	- Load the y test set from "test/y_test.txt" into 'ytest' data frame
	- Load the subject test set from "test/subject_test.txt" into 'stest' data frame
	- Column-bind the subject, X and y train sets into a single 'train' data frame (using the cbind() function)
	- Column-bind the subject, X and y test sets into a single 'test' data frame (using the cbind() function)
	- Row-bind the train and test sets from the two above steps into a data frame named 'dataset'
<br><br>

2. The columns in the merged data set were renamed to use descriptive variable names as follows:

	- Read the features table from "features.txt" into 'features' data frame
	- Create a vector 'columns' containing the column names  for the merged data set - those names are "subject", the list of feature names loaded in the previous step, and "activity"
	- Update the colnames attribute of the merged data set with the vector of column names
<br><br>

3. For the features, only the columns for the mean and standard deviation for each measurement were extracted (along with the subject and activity columns) were kept in the 'dataset' data frame via the subset() function.

4. The activities in the merged data set were labeled using descriptive activity names loaded from the "activity_labels.txt" file by converting the 'activity' column into a factor.

5. A new second, independent tidy data set was created with the average of each variable calculated by subject and activity, using the aggregate() function. The grouping columns were relabeled "subject" and "activity" in the resulting tidy data frame.

6. The final tidy data set from step 5 was written to a text file "tidy_data_set.txt". The output is space-separarated and includes the column header. Row indices are not included.

==========

### Data description:
The list below presents the columns available in the tidy dataset:

- subject: identifier for the subject
- activity: categorical variable with the possible values: 1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS, 4 SITTING, 5 STANDING 6, LAYING
- The features' means in the same unit as the features (see features_info.txt for details on the features):
	- tBodyAcc-mean()-X
	- tBodyAcc-mean()-Y
	- tBodyAcc-mean()-Z
	- tGravityAcc-mean()-X
	- tGravityAcc-mean()-Y
	- tGravityAcc-mean()-Z
	- tBodyAccJerk-mean()-X
	- tBodyAccJerk-mean()-Y
	- tBodyAccJerk-mean()-Z
	- tBodyGyro-mean()-X
	- tBodyGyro-mean()-Y
	- tBodyGyro-mean()-Z
	- tBodyGyroJerk-mean()-X
	- tBodyGyroJerk-mean()-Y
	- tBodyGyroJerk-mean()-Z
	- tBodyAccMag-mean()
	- tGravityAccMag-mean()
	- tBodyAccJerkMag-mean()
	- tBodyGyroMag-mean()
	- tBodyGyroJerkMag-mean()
	- fBodyAcc-mean()-X
	- fBodyAcc-mean()-Y
	- fBodyAcc-mean()-Z
	- fBodyAccJerk-mean()-X
	- fBodyAccJerk-mean()-Y
	- fBodyAccJerk-mean()-Z
	- fBodyGyro-mean()-X
	- fBodyGyro-mean()-Y
	- fBodyGyro-mean()-Z
	- fBodyAccMag-mean()
	- fBodyBodyAccJerkMag-mean()
	- fBodyBodyGyroMag-mean()
	- fBodyBodyGyroJerkMag-mean()
- The features' standard deviations in the same unit as the features (see features_info.txt for details on the features):
	- tBodyAcc-std()-X
	- tBodyAcc-std()-Y
	- tBodyAcc-std()-Z
	- tGravityAcc-std()-X
	- tGravityAcc-std()-Y
	- tGravityAcc-std()-Z
	- tBodyAccJerk-std()-X
	- tBodyAccJerk-std()-Y
	- tBodyAccJerk-std()-Z
	- tBodyGyro-std()-X
	- tBodyGyro-std()-Y
	- tBodyGyro-std()-Z
	- tBodyGyroJerk-std()-X
	- tBodyGyroJerk-std()-Y
	- tBodyGyroJerk-std()-Z
	- tBodyAccMag-std()
	- tGravityAccMag-std()
	- tBodyAccJerkMag-std()
	- tBodyGyroMag-std()
	- tBodyGyroJerkMag-std()
	- fBodyAcc-std()-X
	- fBodyAcc-std()-Y
	- fBodyAcc-std()-Z
	- fBodyAccJerk-std()-X
	- fBodyAccJerk-std()-Y
	- fBodyAccJerk-std()-Z
	- fBodyGyro-std()-X
	- fBodyGyro-std()-Y
	- fBodyGyro-std()-Z
	- fBodyAccMag-std()
	- fBodyBodyAccJerkMag-std()
	- fBodyBodyGyroMag-std()
	- fBodyBodyGyroJerkMag-std()
