# Uses the datasets from 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
# Combines the training and testing datasets into 1.  Then uses them to fine the
# mean of all features in X accross the training and testing datasets.  Only
# done for features that are the mean or standard deviation of people.

# start by combining the feature data
data_train_X = './getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt'
train_X <- read.table(data_train_X)
data_test_X = './getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt'
test_X <- read.table(data_test_X)
data_X <- rbind(train_X, test_X)
# get names of features for X data
feat_names = './getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt'
col_names_X <- read.table(feat_names)
# remove 1st row which has list number of features
col_names_X <- col_names_X[, 2]
# gets name of all columns that are a mean or std
mean_std_names <- grepl('mean()', col_names_X, fixed=TRUE) | 
    grepl('std()', col_names_X, fixed=TRUE)
# renames columns to descriptive names
colnames(data_X) <- col_names_X
# remove unwanted rows from data_X
data_X <- data_X[, mean_std_names]

data_train_y = './getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt'
train_y <- read.table(data_train_y)
data_test_y = './getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt'
test_y <- read.table(data_test_y)
data_y <- rbind(train_y, test_y)
# activity label for all activity number
y_name_id = './getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt'
named_data_y = read.table(y_name_id)
# so merge does not change row order
data_y$row_order <- 1:nrow(data_y)
# left joins activity label on numbers representing then for each datapoint
named_y <- merge(data_y, named_data_y, all.x = TRUE, by='V1', sort=FALSE)
named_y <- named_y[order(named_y$row_order), ]
all_data <- data_X
# final dataframe wanted
all_data$activity <-named_y$V2

# Used to add all feature activity combination means to later dataframe.
all_means <- list()
combined_categories <- list()
# goes through every feature
for (act_name in named_data_y$V2) {

    # get only data with activity being done and remove activity
    temp_table <- subset(all_data[all_data$activity == act_name, ],
                         select = -activity)
    # turning column names to activity + data type combination 
    colnames(temp_table) <- gsub('-', '_',
                                paste(colnames(temp_table), act_name, sep = '-'))
    # gsub used to remove characters which turn into '.' in write.table
    colnames(temp_table) <- gsub("(", '', gsub('-', '_', colnames(temp_table)), fixed=TRUE)
    colnames(temp_table) <- gsub(")", '', colnames(temp_table), fixed=TRUE)
    for (col_n in colnames(temp_table)) {
        combined_categories[[length(combined_categories) + 1]] <- col_n
    }
    for (numb in colMeans(temp_table)) {
        all_means[[length(all_means) + 1]] <- as.numeric(numb)
    }
}
# columns are categories + activity.  1 row of values is mean over all subjects
mean_categories <- as.data.frame(all_means, col.names = combined_categories)

write.table(mean_categories, 'run_analysis.txt', row.names=FALSE)

