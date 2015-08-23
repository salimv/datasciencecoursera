library(dplyr)

## Load the test and train data assuming UCI HAR Dataset as the source folder under current directory
test <- read.table("UCI HAR Dataset\\test\\X_test.txt")
train <- read.table("UCI HAR Dataset\\train\\X_train.txt")

## Merge the two datasets
dataset <- rbind(test, train)

# Read labels -  activity and data labels 
activity <- read.table("UCI HAR Dataset\\activity_labels.txt")
data_labels <- read.table("UCI HAR Dataset\\features.txt")

# Red individual test and train activity and subject lists
test_act <- read.table("UCI HAR Dataset\\test\\y_test.txt")
train_act <- read.table("UCI HAR Dataset\\train\\y_train.txt")
dataset_act <-  rbind(test_act, train_act)
test_sub <- read.table("UCI HAR Dataset\\test\\subject_test.txt")
train_sub <- read.table("UCI HAR Dataset\\train\\subject_train.txt")
dataset_sub <-  rbind(test_act, train_act)

#Assign column names to dataset
names(dataset) <- data_labels$V2

#Get the list of columbn indices of mean and std dev measurements colums using labels
meanstd_cols <- grep("mean|std",names(dataset))

#Extract those columns from data set
dataset_meanstd <- dataset[,meanstd_cols]

#Get descriptive names for activity
dataset_act_lbl <- merge(dataset_act, activity)

#Attach activity label and subject list to the mean std data set
dataset_meanstd$activity <- dataset_act_lbl$V2
dataset_meanstd$subject <- dataset_sub$V1

#Create mean for each measurement by subject and activity
sum_tbl <- dataset_meanstd %>% group_by(subject, activity) %>% summarise_each(funs(mean))

#output the table
write.table(sum_tbl, file="tidy_sum_tbl", row.names=FALSE)
