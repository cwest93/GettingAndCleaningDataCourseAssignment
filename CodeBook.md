---
title: "CodeBook"
author: "Cody West"
date: "November 14, 2016"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

#CodeBook

## Task

The task was to write r code that performed the following.

* Merges the training and the test sets to create one data set
* Extracts only the measurements on the main and standard deviation for each measurement
* Uses descriptive activity names to name the activities in the data set
* Appropriately labelsthe data set with descriptive variable names
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

#Implementation

* First the data is downloaded and unzipped, allowing us to actually use the data set
* The test and train data is then read into their variables
* The necessary components of test and train are combined using cbind, and then those two are merged using rbind.
* The code then labels the variables with descriptive names
* The relevant data surrounding mean and standard deviation is then subsetted out
* Then the activities are appropriately labeld using descriptions before being turned into factors along with the subjects
* A new data set is then generated, taking the mean of each one of the variables and grouping by each subject and activity

##Variables

* x_train, x_test, y_train, y_test, subject_train, subject_test contain the test and train data from the downloaded files
* trainData and testData merge those datasets before they are merged together into the data variable
* The appropriate descriptions of the variables are stored in mylabels before they are applied.
* The mean and standard deviation data is then subsetted out into the variable meanStdData.
* The mean of that data is then taken, and stored for each subject and activity into the variable tidyData.
* The data is then written to a file labeled "tidy.txt"
