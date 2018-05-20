library(reshape2)
filename <- "dataset.zip"
## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}
# Load activity labels 
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
#Load features
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])
# Extract only the data on mean and standard deviation
featWanted <- grep(".*mean.*|.*std.*", features[,2])
featWanted.names <- features[featWanted,2]
featWanted.names = gsub('-mean', 'Mean', featWanted.names)
featWanted.names = gsub('-std', 'Std', featWanted.names)
featWanted.names <- gsub('[-()]', '', featWanted.names)
# Load the datasets
#train dataset
traindataset <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresWanted]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
traindataset <- cbind(trainSubjects, trainActivities, traindataset)
#test dataset
testdataset <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresWanted]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
testdataset <- cbind(testSubjects, testActivities, testdataset)
# merge train and test dataset  
allData <- rbind(train, test)
#Labels
colnames(allData) <- c("subject", "activity", featWanted.names)
# turn activities & subjects into factors
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)
allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)
write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
