library("reshape2")

filename <- "phone-data.zip"

if(!file.exists(filename)){
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
  download.file(url,destfile = filename)
  
  unzip(filename)
}

filePath <- "UCI HAR Dataset"

activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

features <- read.table("./UCI HAR Dataset/features.txt")

#Test set
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")

xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")

colnames(xtest) <- features$V2

testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")

testData <- cbind(testSubjects, ytest,xtest)


#Train set
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")

xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")

colnames(xtrain) <- features$V2

trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")

trainData <- cbind(trainSubjects,ytrain,xtrain)


allData <- rbind(testData,trainData)

colnames(allData)[1] <- "subject"
colnames(allData)[2] <- "activity"

meanStdData <- allData[,grepl("activity|subject|mean|std",names((allData)))]

meanStdData$activity <- factor(meanStdData$activity,levels = activities$V1, labels = activities$V2)

colnames(meanStdData) <- gsub("[-()]","",colnames(meanStdData))

meanStdData$subject <- as.factor(meanStdData$subject)

dataMelt <- melt(meanStdData,id=c("subject","activity"))

tidyData <- dcast(dataMelt, subject + activity ~ variable, mean)

write.table(tidyData, file = "tidyData.txt", row.names = FALSE)