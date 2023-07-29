# Getting and Cleaning Data Project
Author: Klent Abistado <br />

## Information
Data Zip File Location: [UC Irvine Repo](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "Clicking will download the data")

## Criteria
1. Tidy dataset. 
2. The Github repo contains the required scripts.
3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
4. The README that explains the analysis files is clear and understandable.

## Assumptions
All needed packages are installed and libraries are loaded.

## Explanation
Simply run the script 'run_analysis.R' from the console.
> source('run_analysis.R')
It will:
1. Download the dataset.
`Set the URL to download the dataset.
Define the file name for the ZIP archive and the destination directory.
Set the destination directory to the current working directory.
Download the ZIP file.
Unzip the downloaded file to the destination directory.
See code lines 4 to 15`
2. Load the needed files to dataframes for processing.
`Load subject data, activity data, feature data. See code lines 17 to 30`
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names. 
5. Extracts only the measurements on the mean and standard deviation for each measurement.
6. Save the first tiday dataset.
7. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
8. Save the second tidy dataset.
