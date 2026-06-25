# CodeBook Human Activity Recognition Using Smartphones Data Analysis

The following codebook describes the data obtained, transformations to it, and final dataset run_analysis.R makes.

## 1. Dataset Information

  The Human Activity Recognition Using Smartphones dataset is used.  It contains data of 30 subjects aged 19-48 while performorming 6 different types of activities.  Overall, 10299 datapoints exist which had features recorded with a Samsung Galaxy S II subjects wore at their waist.
  
  The data can be downloaded from the link 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'.

## 2. Transformations to Data
1. Manually download data from link and unzipped it in the same directory as run_analysis.R
2. Merged X_train.txt and X_test.txt files.  Did the same with the subject_train.txt and subject_test.txt files, then y_train and y_test files.  Used features.txt to get the names for columns in the X(feature) datasets and activity_labels.txt to turn the data from y_ files from a number into a descriptive word. Then the X_, y_, and subject data were joined together.
3. The features from X_ files that contained mean() or std() were kept along with activity names from y_ files and subject number.  All others were removed.
4. Group data by subject and activity then derive mean of each feature from X_ those unique combinations have

## 3. Variables in Final Dataset (run_analysis.txt)
  - subject: Volunteer ID with a range of 1-30
  - activity: The daily activity performed by the volunteer when a datapoint is observed
    - Can be : WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING.
  Subject and activity form a unique identifier in the final dataset
  
  - Means of features that were a mean or standard deviation for all unique 180 combinations of subject and activity
