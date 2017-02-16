#If(!file.exists("UCI Har Dataset")){
  dir.create("UCI HAR Dataset")
  fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileurl,destfile="UCI-HAR-Dataset.zip")
  unzip("UCI-HAR-Dataset.zip")
#}

# Merges the training and the test sets to create one data set.
train_x <- read.table('./UCI HAR Dataset/train/X_train.txt')
test_x <- read.table('./UCI HAR Dataset/test/X_test.txt')
x <- rbind(train_x,test_x)


train_y <- read.table('./UCI HAR Dataset/train/y_train.txt')
test_y <- read.table('./UCI HAR Dataset/test/y_test.txt')
y <- rbind(train_y, test_y)

train_subj <- read.table('./UCI HAR Dataset/train/subject_train.txt')
test_subj <- read.table('./UCI HAR Dataset/test/subject_test.txt')
subj <- rbind(train_subj, test_subj)

# Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table('./UCI HAR Dataset/features.txt')
m_sd <- grep("-mean\\(\\)|-std\\(\\)",features[,2])
x_mean_sd <- x[,m_sd]

names(x_mean_sd) <- features[m_sd, 2]
names(x_mean_sd) <- tolower(names(x_mean_sd)) 
names(x_mean_sd) <- gsub("\\(|\\)", "", names(x_mean_sd))

# Uses descriptive activity names to name the activities in the data set
activities <- read.table('./UCI HAR Dataset/activity_labels.txt')
activities[, 2] <- tolower(as.character(activities[, 2]))
activities[, 2] <- gsub("_", "", activities[, 2])


y[, 1] = activities[y[, 1], 2]
colnames(y) <- 'activity'
colnames(subj) <- 'subject'

#Creates the merged file 
dir.create("Project")
data <- cbind(subj, x_mean_sd, y)
str(data)
write.table(data, './Project/merged.txt')

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
average <- aggregate(x=data, by=list(activities=data$activity, subj=data$subject), FUN=mean)
average <- average[, !(colnames(average) %in% c("subj", "activity"))]
str(average)
write.table(average, './Project/average.txt')
