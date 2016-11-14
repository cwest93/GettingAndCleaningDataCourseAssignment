#Pulls in the URL where the data is store
URL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
#Downloads zip file
download.file(URL, "Dataset.zip")
#unzips file
unzip("Dataset.zip")

#next section reads in the various text files into their respective variables
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
#1 Merges the training and the test sets to create one data set
##binds the test data and training data together to form their larger data sets
testData <- cbind(subject_test, y_test, x_test)
trainData <- cbind(subject_train, y_train, x_train)
##binds the train and test data to form the full data set
data <- rbind(trainData, testData)
#stores the descriptive labels as characters in the variable mylabels
mylabels <- as.character(features[,2])

#4 Appropriately labels the data set with descriptive variable names
#Uses descriptive names to identify the variables, using "mylabels"
colnames(data) <-  c("Subject", "Activity", mylabels)

 #2 Extracts only the measurements on the mean and standard deviation for each measurement
##Pulls in the relevant columns that have a standard deviation or a mean
meanstdFeatures <- grep("([Mm]ean|std)..", features[,2])
##Leaves space for the subject and activity columns that were already attached to the data
meanstdFeatures <- c(1,2,meanstdFeatures+2)
#subsets the full dataset to the specified data which just includes mean and standard deviation
meanStdData <- data[,meanstdFeatures]

#3. Uses descriptive activity names to name the activities in the data set
#labels the activity and subjects as factors, relabels the activity numbers with the correct factor
meanStdData$Activity <- factor(meanStdData$Activity, levels = activity_labels[,1], labels = activity_labels[,2])
meanStdData$Subject <- as.factor(meanStdData$Subject)

#5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject
##creates the tidydata set by taking the mean of each of the variables grouped by subject and activity
tidyData <- aggregate(. ~ Subject + Activity, meanStdData, mean)
##orders the tidy data set
tidyData <- tidyData[order(tidyData$Subject, tidyData$Activity),]
##writes the tidy data to a text document
write.table(tidyData, "tidy.txt", row.names = FALSE, quote = FALSE)
