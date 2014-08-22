# Source code for Project 2 of "Getting and Cleaning" Data class

# loads the X for train dataset
Xtrain.init <- read.table("train/X_train.txt", nrows = 100)
Xtrain.classes <- sapply(Xtrain.init, class)
Xtrain <- read.table("train/X_train.txt", colClasses = Xtrain.classes)
dim(Xtrain)

# loads the y for train dataset
ytrain.init <- read.table("train/y_train.txt", nrows = 100)
ytrain.classes <- sapply(ytrain.init, class)
ytrain <- read.table("train/y_train.txt", colClasses = ytrain.classes)
dim(ytrain)

# loads the subjects for train dataset
strain.init <- read.table("train/subject_train.txt", nrows = 100)
strain.classes <- sapply(strain.init, class)
strain <- read.table("train/subject_train.txt", colClasses = strain.classes)
dim(strain)

# loads the X for test dataset
Xtest.init <- read.table("test/X_test.txt", nrows = 100)
Xtest.classes <- sapply(Xtest.init, class)
Xtest <- read.table("test/X_test.txt", colClasses = Xtest.classes)
dim(Xtest)

# loads the y for test dataset
ytest.init <- read.table("test/y_test.txt", nrows = 100)
ytest.classes <- sapply(ytest.init, class)
ytest <- read.table("test/y_test.txt", colClasses = ytest.classes)
dim(ytest)

# loads the subjects for test dataset
stest.init <- read.table("test/subject_test.txt", nrows = 100)
stest.classes <- sapply(stest.init, class)
stest <- read.table("test/subject_test.txt", colClasses = stest.classes)
dim(stest)

# column-binds all the dataframes for the train set and for the test set
train <- cbind(strain, Xtrain, ytrain)
test <- cbind(stest, Xtest, ytest)
# row-binds train and test sets
dataset <- rbind(train, test)
dim(dataset)

# labels the columns in the dataset
features <- read.table("features.txt")
columns <- c("subject", as.vector(features[["V2"]]), "activity")
colnames(dataset) <- columns

# convert activities into a factor
labels <- read.table("activity_labels.txt")
dataset$activity <- factor(dataset$activity, levels=seq(1,6), labels=as.vector(labels[["V2"]]))
dataset$subject <- factor(dataset$subject)

# for each measurement, only keep the columns for mean and standard deviation 
keep.features <- c(grep("-mean\\(\\)", columns, value=TRUE), grep("-std\\(\\)", columns, value=TRUE))
dataset <- subset(dataset, select=c("subject", keep.features, "activity"))

# create a tidy dataset that contains the average of the mean and standard deviations
# by subject and activity
tidy.data <-aggregate(dataset[,keep.features], by=list(dataset$subject, dataset$activity), FUN=mean, na.rm=TRUE)
colnames(tidy.data) <- c("subject", "activity", keep.features)

# finally, writes tidy dataset into test file
write.table(tidy.data, file="tidy_data_set.txt", row.names = TRUE)
