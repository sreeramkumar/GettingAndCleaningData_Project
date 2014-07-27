#       Read test data - 3 files
#       Read train data - 3 files
#       Read Activity Labels
#       Add subject and activity to the variables file - cbind
#       add both these together - rbind
#       merge with activity labels - merge
#       subset required columns
#       change variable names - use merge for vector and use it for column names
#       Mutate the data for averages

test_subject <- read.table("./test/subject_test.txt")
test_activity <- read.table("./test/y_test.txt")
test_features <- read.table("./test/X_test.txt")
train_subject <- read.table("./train/subject_train.txt")
train_activity <- read.table("./train/y_train.txt")
train_features <- read.table("./train/X_train.txt")
activity_label <- read.table("activity_labels.txt")
features <- read.table("features.txt")
names(test_features) <- features[,2]
names(train_features) <- features[,2]


ptn <- '*mean*' 
ptn1 <- '*meanFreq*'
ptn2 <- '*std*'

means <- grep(ptn, features$V2)
meanFreqs <- grep(ptn1, features$V2)
stds <- grep(ptn2, features$V2)

cols <- sort(c(setdiff(means, meanFreqs), stds))

test_features <- test_features[,cols]
train_features <- train_features[,cols]

test_features$subject <- test_subject[,1]
test_features$activity <- test_activity[,1]
train_features$subject <- train_subject[,1]
train_features$activity <- train_activity[,1]
first <- rbind(test_features, train_features)
names(activity_label) <- c("activity", "Activity-Label")
first <- merge(first, activity_label, by = "activity", all = TRUE)
first<- first[,-1]
newNames <- read.table("colNames.txt")
names(first) <- newNames[,1]
second <- aggregate(first[,c(-67,-68)], by=list(first$Subject, first$Activity-Label), FUN = mean)
write.table(second, file = "tidyData.txt", row.names = FALSE)
