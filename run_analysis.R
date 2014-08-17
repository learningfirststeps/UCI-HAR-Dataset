# "Use descriptive activity names to name the activities in the data set"*
## *) quote from assignment

## Merge activity lables in train and test datasets
activitylabels <- read.csv("activity_labels.txt", header=FALSE, sep=" ")
names(activitylabels) <- c("id", "activity label")

trainlabels <- read.csv("./train/Y_train.txt", header=FALSE, sep=" ")
names(trainlabels) <- "id"
trainlabels <- merge(trainlabels, activitylabels, by.x="id", by.y="id", all=TRUE) 

testlabels <- read.csv("./test/Y_test.txt", header=FALSE, sep=" ")
names(testlabels) <- "id"
testlabels <- merge(testlabels, activitylabels, by.x="id", by.y="id", all=TRUE) 

## Merge subject and activity in train and test datasets
subjecttrain <- read.csv("./train/subject_train.txt", header=FALSE, sep=" ")
names(subjecttrain) <- "subject"

subjecttest <- read.csv("./test/subject_test.txt", header=FALSE, sep=" ")
names(subjecttest) <- "subject"

trainjoined <- cbind(trainlabels, subjecttrain)
testjoined <- cbind(testlabels, subjecttest)


# "Appropriately labels the data set with descriptive variable names"
## *) quote from assignment

## Read labels from features.txt
featurelabels <- read.csv("features.txt", header=FALSE, sep=" ")
names(featurelabels) <- c("id", "feature label")
ns <- c( t( as.matrix( featurelabels[,"feature label"] ) ) ) # convert to a vector

# "Merge the training and the test sets to create one data set."*
## *) quote from assignment

## Read train and test sets and name collumns
trainset <- scan("./train/X_train.txt", what = double(), sep="", dec=".")
dim(trainset) <- c(7352,561)
trainset <- data.frame(trainset)
names(trainset) <- ns

testset <- scan("./test/X_test.txt", what = double(), sep="", dec=".")
dim(testset) <- c(2947,561)
testset <- data.frame(testset)
names(testset) <- ns

## join activities and sets. join train and test
trainjoined <- cbind(trainjoined, trainset)
testjoined <- cbind(testjoined, testset)
alljoined <- rbind(trainjoined, testjoined)

# make tidy data according to assignment
# "Extracts only the measurements on the mean and standard deviation for each measurement."*
## *) quote from the assignment

lnames <- c("tBodyAcc-mean()-X",
            "tBodyAcc-mean()-Y",
            "tBodyAcc-mean()-Z",
            "tBodyAcc-std()-X",
            "tBodyAcc-std()-Y",
            "tBodyAcc-std()-Z")

first <- alljoined[, c( "activity label", "subject", lnames )]

first[,"tBodyAcc-mean()-X"] <- as.numeric(first[,"tBodyAcc-mean()-X"])
first[,"tBodyAcc-mean()-Y"] <- as.numeric(first[,"tBodyAcc-mean()-Y"])
first[,"tBodyAcc-mean()-Z"] <- as.numeric(first[,"tBodyAcc-mean()-Z"])
first[,"tBodyAcc-std()-X"]  <- as.numeric(first[,"tBodyAcc-std()-X"])
first[,"tBodyAcc-std()-Y"]  <- as.numeric(first[,"tBodyAcc-std()-Y"])
first[,"tBodyAcc-std()-Z"]  <- as.numeric(first[,"tBodyAcc-std()-Z"])

# "Create a second, independent tidy data set with the average of each variable for each 
# activity and each subject."
## *) quote from the assignment

second <- data.frame( row.names = c( "activity label", "subject", lnames ) )

library(reshape2)
firstMelt <- melt(first, id=c("activity label", "subject"), measure.vars = lnames) 
second <- dcast(firstMelt, `activity label` + subject ~ variable, mean)

# correct column names, to reflect that they are means
names(second) <- c("activity label", 
                   "subject",
                   "mean(tBodyAcc-mean()-X)",
                   "mean(tBodyAcc-mean()-Y)",
                   "mean(tBodyAcc-mean()-Z)",
                   "mean(tBodyAcc-std()-X)",
                   "mean(tBodyAcc-std()-Y)",
                   "mean(tBodyAcc-std()-Z)")

# save the result for assignment result sumbmition

write.table(second, "second_tidy_data.txt", row.names=FALSE) 
       