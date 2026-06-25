# Uses the datasets from 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
# Combines the training and testing datasets into 1.  Then uses them to find the
# mean of all unique activity and subject combination in X across the training
# and testing datasets.  Only done for features that are the mean or standard
# deviation of people.

# start by combining the feature data
data_train_X <- './getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt'
train_X <- read.table(data_train_X, colClasses='numeric')
subject_train <- './getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt'
train_sub  <- read.table(subject_train, colClasses='integer')
subject_list <- as.list( train_sub[,'V1'])

data_test_X <- './getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt'
test_X <- read.table(data_test_X, colClasses='numeric')
subject_test <- './getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt'
test_sub <- read.table(subject_test, colClasses='integer')
subject_list <- c(subject_list, as.list(test_sub[,'V1']))

data_X <- rbind(train_X, test_X)
# get names of features for X data
feat_names = './getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt'
col_names_X <- read.table(feat_names)
# remove 1st row which has list number of features
col_names_X <- col_names_X[, 2]
# gets name of all columns that are a mean, std, or subject
mean_std_names <- grepl('mean()', col_names_X, fixed=TRUE) | 
    grepl('std()', col_names_X, fixed=TRUE)
# renames columns to descriptive names
colnames(data_X) <- col_names_X
# remove unwanted rows from data_X
data_X <- data_X[, mean_std_names]
data_X['subject'] <- unlist(subject_list)

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

# gsub used to remove column characters which turn into '.' in write.table
colnames(all_data) <- gsub("(", '', gsub('-', '_', colnames(all_data)), fixed=TRUE)
colnames(all_data) <- gsub(")", '', colnames(all_data), fixed=TRUE)
# have sugject and activity as the first columns for readability
all_data <- all_data[, c(length(colnames(all_data)) - 1,
                         length(colnames(all_data)),
                        1:(length(colnames(all_data)) - 2))]
# Used to add all means of datapoints with the same subject and activity
mean_categories = data.frame(matrix(ncol = length(colnames(all_data)), 
                                    nrow=0) )

# goes through every subject
for (subject_n in sort(unique(all_data$subject))) {
    # goes through every activity
    for (act_name in sort(named_data_y$V2)) {
    
        # get only mean/std data with wanted activity + subject
        # remove activity + subject as not needed for mean
        temp_table <- subset(all_data[(all_data$activity == act_name) &
                                      (all_data$subject == subject_n), ],
                             select = -c(subject, activity))
        mean_categories <- rbind(mean_categories,
                                 c(subject_n, act_name, colMeans(temp_table)))
    }
}
# for correct columns
colnames(mean_categories) <- colnames(all_data)
mean_categories[, 1] <- as.integer(mean_categories[, 1])
columns_total <- length(colnames(mean_categories))
mean_categories[, 3:columns_total] <- lapply(mean_categories[, 3:columns_total], as.numeric)
# columns are categories.  1 row of values is mean over for 1 subject + activity
write.table(mean_categories, 'run_analysis.txt', row.names=FALSE)
