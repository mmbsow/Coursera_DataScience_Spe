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
<br><br>

- subject: identifier for the subject

<br>

- activity: categorical variable with the possible values: 1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS, 4 SITTING, 5 STANDING 6, LAYING

<br>

- The features' means in the same unit as the features (see features_info.txt for details on the features):
	- tBodyAcc-mean()-X: mean value for body acceleration signals in X dimension
	- tBodyAcc-mean()-Y: mean value for body acceleration signals in Y dimension
	- tBodyAcc-mean()-Z: mean value for body acceleration signals in Z dimension
	- tGravityAcc-mean()-X: mean value for gravity acceleration signals in X dimension
	- tGravityAcc-mean()-Y: mean value for gravity acceleration signals in Y dimension
	- tGravityAcc-mean()-Z: mean value for gravity acceleration signals in Z dimension
	- tBodyAccJerk-mean()-X: mean value for jerk signals for body linear acceleration in X dimension
	- tBodyAccJerk-mean()-Y: mean value for jerk signals for body linear acceleration in Y dimension
	- tBodyAccJerk-mean()-Z: mean value for jerk signals for body linear acceleration in Z dimension
	- tBodyGyro-mean()-X: mean value for body angular velocity signals in X dimension
	- tBodyGyro-mean()-Y: mean value for body angular velocity signals in Y dimension
	- tBodyGyro-mean()-Z: mean value for body angular velocity signals in Z dimension
	- tBodyGyroJerk-mean()-X: mean value for jerk signals for body angular velocity in X dimension
	- tBodyGyroJerk-mean()-Y: mean value for jerk signals for body angular velocity in Y dimension
	- tBodyGyroJerk-mean()-Z: mean value for jerk signals for body angular velocity in Z dimension
	- tBodyAccMag-mean(): mean value for body acceleration signals' magnitude
	- tGravityAccMag-mean(): mean value for gravity acceleration signals' magnitude
	- tBodyAccJerkMag-mean(): mean value for jerk signals' magnitude for body linear acceleration
	- tBodyGyroMag-mean(): mean value for body angular velocity signals' magnitude
	- tBodyGyroJerkMag-mean(): mean value for jerk signals' magnitude for body angular velocity
	- fBodyAcc-mean()-X: mean value for Fast Fourier Transform (FFT) for body acceleration signals in X dimension
	- fBodyAcc-mean()-Y: mean value for FFT for body acceleration signals in Y dimension
	- fBodyAcc-mean()-Z: mean value for FFT for body acceleration signals in Z dimension
	- fBodyAccJerk-mean()-X: mean value for FFT for jerk signals for body linear acceleration in X dimension
	- fBodyAccJerk-mean()-Y: mean value for FFT for jerk signals for body linear acceleration in Y dimension
	- fBodyAccJerk-mean()-Z: mean value for FFT for jerk signals for body linear acceleration in Z dimension
	- fBodyGyro-mean()-X: mean value for FFT for body angular velocity signals in X dimension
	- fBodyGyro-mean()-Y: mean value for FFT for body angular velocity signals in Y dimension
	- fBodyGyro-mean()-Z: mean value for FFT for body angular velocity signals in Z dimension
	- fBodyAccMag-mean(): mean value for FFT for body acceleration signals' magnitude
	- fBodyBodyAccJerkMag-mean(): mean value for FFT for jerk signals' magnitude for body linear acceleration
	- fBodyBodyGyroMag-mean(): mean value for FFT for body angular velocity signals' magnitude
	- fBodyBodyGyroJerkMag-mean(): mean value for FFT for jerk signals' magnitude for body angular velocity

<br>

- The features' standard deviations in the same unit as the features (see features_info.txt for details on the features):
	- tBodyAcc-std()-X: standard deviation value for body acceleration signals in X dimension
	- tBodyAcc-std()-Y: standard deviation value for body acceleration signals in Y dimension
	- tBodyAcc-std()-Z: standard deviation value for body acceleration signals in Z dimension
	- tGravityAcc-std()-X: standard deviation value for gravity acceleration signals in X dimension
	- tGravityAcc-std()-Y: standard deviation value for gravity acceleration signals in Y dimension
	- tGravityAcc-std()-Z: standard deviation value for gravity acceleration signals in Z dimension
	- tBodyAccJerk-std()-X: standard deviation value for jerk signals for body linear acceleration in X dimension
	- tBodyAccJerk-std()-Y: standard deviation value for jerk signals for body linear acceleration in Y dimension
	- tBodyAccJerk-std()-Z: standard deviation value for jerk signals for body linear acceleration in Z dimension
	- tBodyGyro-std()-X: standard deviation value for body angular velocity signals in X dimension
	- tBodyGyro-std()-Y: standard deviation value for body angular velocity signals in Y dimension
	- tBodyGyro-std()-Z: standard deviation value for body angular velocity signals in Z dimension
	- tBodyGyroJerk-std()-X: standard deviation value for jerk signals for body angular velocity in X dimension
	- tBodyGyroJerk-std()-Y: standard deviation value for jerk signals for body angular velocity in Y dimension
	- tBodyGyroJerk-std()-Z: standard deviation value for jerk signals for body angular velocity in Z dimension
	- tBodyAccMag-std(): standard deviation value for body acceleration signals' magnitude
	- tGravityAccMag-std(): standard deviation value for gravity acceleration signals' magnitude
	- tBodyAccJerkMag-std(): standard deviation value for jerk signals' magnitude for body linear acceleration
	- tBodyGyroMag-std(): standard deviation value for body angular velocity signals' magnitude
	- tBodyGyroJerkMag-std(): standard deviation value for jerk signals' magnitude for body linear acceleration
	- fBodyAcc-std()-X: standard deviation value for Fast Fourier Transform (FFT) for body acceleration signals in X dimension
	- fBodyAcc-std()-Y: standard deviation value for FFT for body acceleration signals in Y dimension
	- fBodyAcc-std()-Z: standard deviation value for FFT for body acceleration signals in Z dimension
	- fBodyAccJerk-std()-X: standard deviation value for FFT for jerk signals for body linear acceleration in X dimension
	- fBodyAccJerk-std()-Y: standard deviation value for FFT for jerk signals for body linear acceleration in Y dimension
	- fBodyAccJerk-std()-Z: standard deviation value for FFT for jerk signals for body linear acceleration in Z dimension
	- fBodyGyro-std()-X: standard deviation value for FFT for body angular velocity signals in X dimension
	- fBodyGyro-std()-Y: standard deviation value for FFT for body angular velocity signals in Y dimension
	- fBodyGyro-std()-Z: standard deviation value for FFT for body angular velocity signals in Z dimension
	- fBodyAccMag-std(): standard deviation value for FFT for body acceleration signals' magnitude
	- fBodyBodyAccJerkMag-std(): standard deviation value for FFT for jerk signals' magnitude for body linear acceleration
	- fBodyBodyGyroMag-std(): standard deviation value for FFT for body angular velocity signals' magnitude
	- fBodyBodyGyroJerkMag-std(): standard deviation value for FFT for jerk signals' magnitude for body angular velocity

<br>
