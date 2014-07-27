
#       Read test data from the three files in "test" sub folder.
test_subject <- read.table("./test/subject_test.txt")
test_activity <- read.table("./test/y_test.txt")
test_features <- read.table("./test/X_test.txt")

#       Read train data from the three files in "train" sub folder.
train_subject <- read.table("./train/subject_train.txt")
train_activity <- read.table("./train/y_train.txt")
train_features <- read.table("./train/X_train.txt")

#       Read the file "activity_labels.txt". 
#       This data is used to give full names to activities in the data set.
activity_label <- read.table("activity_labels.txt")

#       Read the file "features.txt". 
#       This data is used to select the required columns from the data set.
features <- read.table("features.txt")

#       Assign the feature names (second column) from features to 
#       the column names for test and train features data. 
#       This gives proper names to the columns.
names(test_features) <- features[,2]
names(train_features) <- features[,2]

#       Define the patterns to be used for matching the feature names
ptn <- '*mean*' 
ptn1 <- '*meanFreq*'
ptn2 <- '*std*'

#       Find indices where each of the pattern is matching the feature names.
means <- grep(ptn, features$V2)
meanFreqs <- grep(ptn1, features$V2)
stds <- grep(ptn2, features$V2)

#       Get the required indices
cols <- sort(c(setdiff(means, meanFreqs), stds))

#       Subset test features and train features based on the required column indices 
test_features <- test_features[,cols]
train_features <- train_features[,cols]

#       Add the data from subject and activity to the above subset of features for both test and train data.
test_features$subject <- test_subject[,1]
test_features$activity <- test_activity[,1]
train_features$subject <- train_subject[,1]
train_features$activity <- train_activity[,1]

#       Combine test and train data sets to get the first required data set.
first <- rbind(test_features, train_features)

#       Add column names to activity labels so we can use them for merge.
#       column name for activity should match in both data sets.
names(activity_label) <- c("activity", "Activity_Label")

#        Merge the first data set with activity label to expand the activity names
first <- merge(first, activity_label, by = "activity", all = TRUE)

#       Get rid of the activity number as we have the names now.
first<- first[,-1]

#       Read meaningful names from the new file and assign them to the column names
newNames <- read.table("colNames.txt")
names(first) <- newNames[,1]

#       Use aggregate function to calculate means for all variables.
second <- aggregate(first[,c(-67,-68)], by=list(first$Subject, first$Activity_Label), FUN = mean)

#       Update column names for the id fields, to remove the default names.
names(second)[c(1,2)] <- c("Subject", "Activity_Label")

#       Write the data set into a file for submission
write.table(second, file = "tidyData.txt", row.names = FALSE)
