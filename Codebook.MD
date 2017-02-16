run_analysis.R
Ajay Kalekar

Thu Feb 16 17:01:08 2017

#If(!file.exists("UCI Har Dataset")){
  dir.create("UCI HAR Dataset")
## Warning in dir.create("UCI HAR Dataset"): 'UCI HAR Dataset' already exists
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
## Warning in dir.create("Project"): 'Project' already exists
data <- cbind(subj, x_mean_sd, y)
str(data)
## 'data.frame':    10299 obs. of  68 variables:
##  $ subject                  : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ tbodyacc-mean-x          : num  0.289 0.278 0.28 0.279 0.277 ...
##  $ tbodyacc-mean-y          : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
##  $ tbodyacc-mean-z          : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
##  $ tbodyacc-std-x           : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
##  $ tbodyacc-std-y           : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
##  $ tbodyacc-std-z           : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
##  $ tgravityacc-mean-x       : num  0.963 0.967 0.967 0.968 0.968 ...
##  $ tgravityacc-mean-y       : num  -0.141 -0.142 -0.142 -0.144 -0.149 ...
##  $ tgravityacc-mean-z       : num  0.1154 0.1094 0.1019 0.0999 0.0945 ...
##  $ tgravityacc-std-x        : num  -0.985 -0.997 -1 -0.997 -0.998 ...
##  $ tgravityacc-std-y        : num  -0.982 -0.989 -0.993 -0.981 -0.988 ...
##  $ tgravityacc-std-z        : num  -0.878 -0.932 -0.993 -0.978 -0.979 ...
##  $ tbodyaccjerk-mean-x      : num  0.078 0.074 0.0736 0.0773 0.0734 ...
##  $ tbodyaccjerk-mean-y      : num  0.005 0.00577 0.0031 0.02006 0.01912 ...
##  $ tbodyaccjerk-mean-z      : num  -0.06783 0.02938 -0.00905 -0.00986 0.01678 ...
##  $ tbodyaccjerk-std-x       : num  -0.994 -0.996 -0.991 -0.993 -0.996 ...
##  $ tbodyaccjerk-std-y       : num  -0.988 -0.981 -0.981 -0.988 -0.988 ...
##  $ tbodyaccjerk-std-z       : num  -0.994 -0.992 -0.99 -0.993 -0.992 ...
##  $ tbodygyro-mean-x         : num  -0.0061 -0.0161 -0.0317 -0.0434 -0.034 ...
##  $ tbodygyro-mean-y         : num  -0.0314 -0.0839 -0.1023 -0.0914 -0.0747 ...
##  $ tbodygyro-mean-z         : num  0.1077 0.1006 0.0961 0.0855 0.0774 ...
##  $ tbodygyro-std-x          : num  -0.985 -0.983 -0.976 -0.991 -0.985 ...
##  $ tbodygyro-std-y          : num  -0.977 -0.989 -0.994 -0.992 -0.992 ...
##  $ tbodygyro-std-z          : num  -0.992 -0.989 -0.986 -0.988 -0.987 ...
##  $ tbodygyrojerk-mean-x     : num  -0.0992 -0.1105 -0.1085 -0.0912 -0.0908 ...
##  $ tbodygyrojerk-mean-y     : num  -0.0555 -0.0448 -0.0424 -0.0363 -0.0376 ...
##  $ tbodygyrojerk-mean-z     : num  -0.062 -0.0592 -0.0558 -0.0605 -0.0583 ...
##  $ tbodygyrojerk-std-x      : num  -0.992 -0.99 -0.988 -0.991 -0.991 ...
##  $ tbodygyrojerk-std-y      : num  -0.993 -0.997 -0.996 -0.997 -0.996 ...
##  $ tbodygyrojerk-std-z      : num  -0.992 -0.994 -0.992 -0.993 -0.995 ...
##  $ tbodyaccmag-mean         : num  -0.959 -0.979 -0.984 -0.987 -0.993 ...
##  $ tbodyaccmag-std          : num  -0.951 -0.976 -0.988 -0.986 -0.991 ...
##  $ tgravityaccmag-mean      : num  -0.959 -0.979 -0.984 -0.987 -0.993 ...
##  $ tgravityaccmag-std       : num  -0.951 -0.976 -0.988 -0.986 -0.991 ...
##  $ tbodyaccjerkmag-mean     : num  -0.993 -0.991 -0.989 -0.993 -0.993 ...
##  $ tbodyaccjerkmag-std      : num  -0.994 -0.992 -0.99 -0.993 -0.996 ...
##  $ tbodygyromag-mean        : num  -0.969 -0.981 -0.976 -0.982 -0.985 ...
##  $ tbodygyromag-std         : num  -0.964 -0.984 -0.986 -0.987 -0.989 ...
##  $ tbodygyrojerkmag-mean    : num  -0.994 -0.995 -0.993 -0.996 -0.996 ...
##  $ tbodygyrojerkmag-std     : num  -0.991 -0.996 -0.995 -0.995 -0.995 ...
##  $ fbodyacc-mean-x          : num  -0.995 -0.997 -0.994 -0.995 -0.997 ...
##  $ fbodyacc-mean-y          : num  -0.983 -0.977 -0.973 -0.984 -0.982 ...
##  $ fbodyacc-mean-z          : num  -0.939 -0.974 -0.983 -0.991 -0.988 ...
##  $ fbodyacc-std-x           : num  -0.995 -0.999 -0.996 -0.996 -0.999 ...
##  $ fbodyacc-std-y           : num  -0.983 -0.975 -0.966 -0.983 -0.98 ...
##  $ fbodyacc-std-z           : num  -0.906 -0.955 -0.977 -0.99 -0.992 ...
##  $ fbodyaccjerk-mean-x      : num  -0.992 -0.995 -0.991 -0.994 -0.996 ...
##  $ fbodyaccjerk-mean-y      : num  -0.987 -0.981 -0.982 -0.989 -0.989 ...
##  $ fbodyaccjerk-mean-z      : num  -0.99 -0.99 -0.988 -0.991 -0.991 ...
##  $ fbodyaccjerk-std-x       : num  -0.996 -0.997 -0.991 -0.991 -0.997 ...
##  $ fbodyaccjerk-std-y       : num  -0.991 -0.982 -0.981 -0.987 -0.989 ...
##  $ fbodyaccjerk-std-z       : num  -0.997 -0.993 -0.99 -0.994 -0.993 ...
##  $ fbodygyro-mean-x         : num  -0.987 -0.977 -0.975 -0.987 -0.982 ...
##  $ fbodygyro-mean-y         : num  -0.982 -0.993 -0.994 -0.994 -0.993 ...
##  $ fbodygyro-mean-z         : num  -0.99 -0.99 -0.987 -0.987 -0.989 ...
##  $ fbodygyro-std-x          : num  -0.985 -0.985 -0.977 -0.993 -0.986 ...
##  $ fbodygyro-std-y          : num  -0.974 -0.987 -0.993 -0.992 -0.992 ...
##  $ fbodygyro-std-z          : num  -0.994 -0.99 -0.987 -0.989 -0.988 ...
##  $ fbodyaccmag-mean         : num  -0.952 -0.981 -0.988 -0.988 -0.994 ...
##  $ fbodyaccmag-std          : num  -0.956 -0.976 -0.989 -0.987 -0.99 ...
##  $ fbodybodyaccjerkmag-mean : num  -0.994 -0.99 -0.989 -0.993 -0.996 ...
##  $ fbodybodyaccjerkmag-std  : num  -0.994 -0.992 -0.991 -0.992 -0.994 ...
##  $ fbodybodygyromag-mean    : num  -0.98 -0.988 -0.989 -0.989 -0.991 ...
##  $ fbodybodygyromag-std     : num  -0.961 -0.983 -0.986 -0.988 -0.989 ...
##  $ fbodybodygyrojerkmag-mean: num  -0.992 -0.996 -0.995 -0.995 -0.995 ...
##  $ fbodybodygyrojerkmag-std : num  -0.991 -0.996 -0.995 -0.995 -0.995 ...
##  $ activity                 : chr  "standing" "standing" "standing" "standing" ...
write.table(data, './Project/merged.txt')

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
average <- aggregate(x=data, by=list(activities=data$activity, subj=data$subject), FUN=mean)
## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA
## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA

## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
## returning NA
average <- average[, !(colnames(average) %in% c("subj", "activity"))]
str(average)
## 'data.frame':    180 obs. of  68 variables:
##  $ activities               : chr  "laying" "sitting" "standing" "walking" ...
##  $ subject                  : num  1 1 1 1 1 1 2 2 2 2 ...
##  $ tbodyacc-mean-x          : num  0.222 0.261 0.279 0.277 0.289 ...
##  $ tbodyacc-mean-y          : num  -0.04051 -0.00131 -0.01614 -0.01738 -0.00992 ...
##  $ tbodyacc-mean-z          : num  -0.113 -0.105 -0.111 -0.111 -0.108 ...
##  $ tbodyacc-std-x           : num  -0.928 -0.977 -0.996 -0.284 0.03 ...
##  $ tbodyacc-std-y           : num  -0.8368 -0.9226 -0.9732 0.1145 -0.0319 ...
##  $ tbodyacc-std-z           : num  -0.826 -0.94 -0.98 -0.26 -0.23 ...
##  $ tgravityacc-mean-x       : num  -0.249 0.832 0.943 0.935 0.932 ...
##  $ tgravityacc-mean-y       : num  0.706 0.204 -0.273 -0.282 -0.267 ...
##  $ tgravityacc-mean-z       : num  0.4458 0.332 0.0135 -0.0681 -0.0621 ...
##  $ tgravityacc-std-x        : num  -0.897 -0.968 -0.994 -0.977 -0.951 ...
##  $ tgravityacc-std-y        : num  -0.908 -0.936 -0.981 -0.971 -0.937 ...
##  $ tgravityacc-std-z        : num  -0.852 -0.949 -0.976 -0.948 -0.896 ...
##  $ tbodyaccjerk-mean-x      : num  0.0811 0.0775 0.0754 0.074 0.0542 ...
##  $ tbodyaccjerk-mean-y      : num  0.003838 -0.000619 0.007976 0.028272 0.02965 ...
##  $ tbodyaccjerk-mean-z      : num  0.01083 -0.00337 -0.00369 -0.00417 -0.01097 ...
##  $ tbodyaccjerk-std-x       : num  -0.9585 -0.9864 -0.9946 -0.1136 -0.0123 ...
##  $ tbodyaccjerk-std-y       : num  -0.924 -0.981 -0.986 0.067 -0.102 ...
##  $ tbodyaccjerk-std-z       : num  -0.955 -0.988 -0.992 -0.503 -0.346 ...
##  $ tbodygyro-mean-x         : num  -0.0166 -0.0454 -0.024 -0.0418 -0.0351 ...
##  $ tbodygyro-mean-y         : num  -0.0645 -0.0919 -0.0594 -0.0695 -0.0909 ...
##  $ tbodygyro-mean-z         : num  0.1487 0.0629 0.0748 0.0849 0.0901 ...
##  $ tbodygyro-std-x          : num  -0.874 -0.977 -0.987 -0.474 -0.458 ...
##  $ tbodygyro-std-y          : num  -0.9511 -0.9665 -0.9877 -0.0546 -0.1263 ...
##  $ tbodygyro-std-z          : num  -0.908 -0.941 -0.981 -0.344 -0.125 ...
##  $ tbodygyrojerk-mean-x     : num  -0.1073 -0.0937 -0.0996 -0.09 -0.074 ...
##  $ tbodygyrojerk-mean-y     : num  -0.0415 -0.0402 -0.0441 -0.0398 -0.044 ...
##  $ tbodygyrojerk-mean-z     : num  -0.0741 -0.0467 -0.049 -0.0461 -0.027 ...
##  $ tbodygyrojerk-std-x      : num  -0.919 -0.992 -0.993 -0.207 -0.487 ...
##  $ tbodygyrojerk-std-y      : num  -0.968 -0.99 -0.995 -0.304 -0.239 ...
##  $ tbodygyrojerk-std-z      : num  -0.958 -0.988 -0.992 -0.404 -0.269 ...
##  $ tbodyaccmag-mean         : num  -0.8419 -0.9485 -0.9843 -0.137 0.0272 ...
##  $ tbodyaccmag-std          : num  -0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...
##  $ tgravityaccmag-mean      : num  -0.8419 -0.9485 -0.9843 -0.137 0.0272 ...
##  $ tgravityaccmag-std       : num  -0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...
##  $ tbodyaccjerkmag-mean     : num  -0.9544 -0.9874 -0.9924 -0.1414 -0.0894 ...
##  $ tbodyaccjerkmag-std      : num  -0.9282 -0.9841 -0.9931 -0.0745 -0.0258 ...
##  $ tbodygyromag-mean        : num  -0.8748 -0.9309 -0.9765 -0.161 -0.0757 ...
##  $ tbodygyromag-std         : num  -0.819 -0.935 -0.979 -0.187 -0.226 ...
##  $ tbodygyrojerkmag-mean    : num  -0.963 -0.992 -0.995 -0.299 -0.295 ...
##  $ tbodygyrojerkmag-std     : num  -0.936 -0.988 -0.995 -0.325 -0.307 ...
##  $ fbodyacc-mean-x          : num  -0.9391 -0.9796 -0.9952 -0.2028 0.0382 ...
##  $ fbodyacc-mean-y          : num  -0.86707 -0.94408 -0.97707 0.08971 0.00155 ...
##  $ fbodyacc-mean-z          : num  -0.883 -0.959 -0.985 -0.332 -0.226 ...
##  $ fbodyacc-std-x           : num  -0.9244 -0.9764 -0.996 -0.3191 0.0243 ...
##  $ fbodyacc-std-y           : num  -0.834 -0.917 -0.972 0.056 -0.113 ...
##  $ fbodyacc-std-z           : num  -0.813 -0.934 -0.978 -0.28 -0.298 ...
##  $ fbodyaccjerk-mean-x      : num  -0.9571 -0.9866 -0.9946 -0.1705 -0.0277 ...
##  $ fbodyaccjerk-mean-y      : num  -0.9225 -0.9816 -0.9854 -0.0352 -0.1287 ...
##  $ fbodyaccjerk-mean-z      : num  -0.948 -0.986 -0.991 -0.469 -0.288 ...
##  $ fbodyaccjerk-std-x       : num  -0.9642 -0.9875 -0.9951 -0.1336 -0.0863 ...
##  $ fbodyaccjerk-std-y       : num  -0.932 -0.983 -0.987 0.107 -0.135 ...
##  $ fbodyaccjerk-std-z       : num  -0.961 -0.988 -0.992 -0.535 -0.402 ...
##  $ fbodygyro-mean-x         : num  -0.85 -0.976 -0.986 -0.339 -0.352 ...
##  $ fbodygyro-mean-y         : num  -0.9522 -0.9758 -0.989 -0.1031 -0.0557 ...
##  $ fbodygyro-mean-z         : num  -0.9093 -0.9513 -0.9808 -0.2559 -0.0319 ...
##  $ fbodygyro-std-x          : num  -0.882 -0.978 -0.987 -0.517 -0.495 ...
##  $ fbodygyro-std-y          : num  -0.9512 -0.9623 -0.9871 -0.0335 -0.1814 ...
##  $ fbodygyro-std-z          : num  -0.917 -0.944 -0.982 -0.437 -0.238 ...
##  $ fbodyaccmag-mean         : num  -0.8618 -0.9478 -0.9854 -0.1286 0.0966 ...
##  $ fbodyaccmag-std          : num  -0.798 -0.928 -0.982 -0.398 -0.187 ...
##  $ fbodybodyaccjerkmag-mean : num  -0.9333 -0.9853 -0.9925 -0.0571 0.0262 ...
##  $ fbodybodyaccjerkmag-std  : num  -0.922 -0.982 -0.993 -0.103 -0.104 ...
##  $ fbodybodygyromag-mean    : num  -0.862 -0.958 -0.985 -0.199 -0.186 ...
##  $ fbodybodygyromag-std     : num  -0.824 -0.932 -0.978 -0.321 -0.398 ...
##  $ fbodybodygyrojerkmag-mean: num  -0.942 -0.99 -0.995 -0.319 -0.282 ...
##  $ fbodybodygyrojerkmag-std : num  -0.933 -0.987 -0.995 -0.382 -0.392 ...
write.table(average, './Project/average.txt')
