# Getting and Cleaning Data Project John Hopkins Coursera
# Author: Klent Abistado

# Set the URL to download the dataset
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Define the file name for the ZIP archive and the destination directory
zip_filename <- "dataFiles.zip"
dest_dir <- getwd()  # Set the destination directory to the current working directory

# Download the ZIP file
download.file(url, destfile = file.path(dest_dir, zip_filename))

# Unzip the downloaded file to the destination directory
unzip(zipfile = file.path(dest_dir, zip_filename), exdir = dest_dir)

# Set the path to the unzipped directory
data_dir <- file.path(dest_dir, "UCI HAR Dataset")

# Load subject data
subject_train <- read.table(file.path(data_dir, "train", "subject_train.txt"), col.names = "subject")
subject_test <- read.table(file.path(data_dir, "test", "subject_test.txt"), col.names = "subject")

# Load activity data
y_train <- read.table(file.path(data_dir, "train", "Y_train.txt"), col.names = "activityLabels")
y_test <- read.table(file.path(data_dir, "test", "Y_test.txt"), col.names = "activityLabels")

# Load feature data
x_train <- read.table(file.path(data_dir, "train", "X_train.txt"))
x_test <- read.table(file.path(data_dir, "test", "X_test.txt"))

# Load the activity labels and convert activity IDs to descriptive names
activity_labels <- read.table(file.path(data_dir, "activity_labels.txt"), col.names = c("classLabels", "activityName"))

# Load the features and convert features IDs to descriptive names
features <- read.table(file.path(data_dir, "features.txt"), col.names = c("featureLabels", "featureNames"))

#Get the target features
featuresWanted <- grep("(mean|std)\\(\\)", features[, "featureNames"])
measurements <- features[featuresWanted, "featureNames"]

#Replace the column names - features IDs to descriptive names
colnames(x_train) <- features[, "featureNames"]
colnames(x_test) <- features[, "featureNames"]

# Remove columns not mentioned in the list
x_train <- x_train[, measurements]
x_test <- x_test[, measurements]

#Merges the training and the test sets including its respective subject to create one data set.
merged_data_train <- cbind(subject_train, y_train, x_train)
merged_data_test <- cbind(subject_test, y_test, x_test)
merged_data <- rbind(merged_data_train, merged_data_test)


# Merge the activity data with the activity labels to get descriptive activity names
library(dplyr)
merged_data <- mutate(merged_data, activityLabels = activity_labels[activityLabels, 'activityName'])
merged_data <- rename(merged_data, Activity = activityLabels)
merged_data <- rename(merged_data, Subject = subject)

write.csv(merged_data, file = "tidy_data_01.csv", row.names = FALSE)

#Create independent tidy data set with the average of each variable for each activity and each subject
library(reshape2)
merged_data[["Subject"]] <- as.factor(merged_data[, "Subject"])
merged_data <- reshape2::melt(data = merged_data, id = c("Subject", "Activity"))
merged_data <- reshape2::dcast(data = merged_data, Subject + Activity ~ variable, fun.aggregate = mean)

write.csv(merged_data, file = "tidy_data_02.csv", row.names = FALSE)
