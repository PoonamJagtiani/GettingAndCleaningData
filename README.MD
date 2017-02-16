Readme

Getting and Cleaning Data Course Project
Instructions for project The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

Merges the training and the test sets to create one data set. Extracts only the measurements on the mean and standard deviation for each measurement. Uses descriptive activity names to name the activities in the data set Appropriately labels the data set with descriptive variable names. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Files in folder ‘UCI HAR Dataset’ that will be used are as following:

1.Subject files :  test/subject_test.txt train/subject_train.txt

2. Activity files : test/X_test.txt train/X_train.txt

3. Data files:  test/y_test.txt train/y_train.txt

4. features.txt - Names of column variables in the dataTable

5. activity_labels.txt - Links the class labels with their activity name.

#Read the above files and create data tables.

train_x <- read.table('./UCI HAR Dataset/train/X_train.txt')
test_x <- read.table('./UCI HAR Dataset/test/X_test.txt')
train_y <- read.table('./UCI HAR Dataset/train/y_train.txt')
test_y <- read.table('./UCI HAR Dataset/test/y_test.txt')
train_subj <- read.table('./UCI HAR Dataset/train/subject_train.txt')
test_subj <- read.table('./UCI HAR Dataset/test/subject_test.txt')


Merge the Files 
x <- rbind(train_x,test_x)
y <- rbind(train_y, test_y)
subj <- rbind(train_subj, test_subj)

# Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table('./UCI HAR Dataset/features.txt')
m_sd <- grep("-mean\\(\\)|-std\\(\\)",features[,2])
x_mean_sd <- x[,m_sd]

# Uses descriptive activity names to name the activities in the data set
activities <- read.table('./UCI HAR Dataset/activity_labels.txt')
activities[, 2] <- tolower(as.character(activities[, 2]))
activities[, 2] <- gsub("_", "", activities[, 2])

y[, 1] = activities[y[, 1], 2]
colnames(y) <- 'activity'
colnames(subj) <- 'subject'

#Creates the merged file 
dir.create("Project")
data <- cbind(subj, x.mean.sd, y)
write.table(data, './Project/merged.txt')

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
average <- aggregate(x=data, by=list(activities=data$activity, subj=data$subject), FUN=mean)
average <- average[, !(colnames(average) %in% c("subj", "activity"))]
str(average)
write.table(average, './Project/average.txt')





