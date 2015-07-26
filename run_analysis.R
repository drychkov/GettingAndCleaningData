library(data.table)
library(dplyr)
library(reshape2)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./getdata-projectfiles-UCI HAR Dataset.zip", method = "curl")
dateDownloaded <- date()
unzip ("./getdata-projectfiles-UCI HAR Dataset.zip", exdir = "./")

features <- read.table("./UCI HAR Dataset/features.txt", colClasses = "character")[,2]
features <- append(c("SubjectId", "Activity"), as.list(features))

activityData <- read.table("./UCI HAR Dataset/activity_labels.txt", colClasses = "character")


X_train = read.table("./UCI HAR Dataset/train/X_train.txt") 
y_train = read.table("./UCI HAR Dataset/train/y_train.txt") 
subject_train = read.table("./UCI HAR Dataset/train/subject_train.txt") 
train <- cbind(subject_train, y_train, X_train)

X_test = read.table("./UCI HAR Dataset/test/X_test.txt") 
y_test = read.table("./UCI HAR Dataset/test/y_test.txt") 
subject_test = read.table("./UCI HAR Dataset/test/subject_test.txt") 
test <- cbind(subject_test, y_test, X_test)



# 1. Merges the training and the test sets to create one data set.
data <- rbind(train, test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

names(data) <- features
data <- data[ , !duplicated(colnames(data))]
filteredData <- select(data, matches("(mean|std)\\(.*\\)"))
filteredData <- cbind(data[,1:2], filteredData)

# 3. Uses descriptive activity names to name the activities in the data set.

filteredData$Activity <- lapply(filteredData$Activity, function(x) {filteredData[filteredData$Activity == x, 2] <- activityData$V2[x]})

# 4. Appropriately labels the data set with descriptive variable names. 

names(filteredData) <- gsub("\\(|\\)", "",names(filteredData))
names(filteredData) <- gsub("-mean", "Mean",names(filteredData))
names(filteredData) <- gsub("-std", "Std",names(filteredData))
names(filteredData) <- gsub("JerkMag","JerkMagnitude",names(filteredData))
names(filteredData) <- gsub("AcckMag","AcckMagnitude",names(filteredData))
names(filteredData) <- gsub("GyroMag","GyroMagnitude",names(filteredData))
names(filteredData) <- gsub("tB","timeB",names(filteredData))
names(filteredData) <- gsub("tG","timeG",names(filteredData))
names(filteredData) <- gsub("fB","freqB",names(filteredData))
names(filteredData) <- gsub("fG","freqG",names(filteredData))


# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

class(filteredData$Activity) <- "character"
summaryData <- filteredData %>% group_by(SubjectId, Activity) %>% summarise_each(funs(mean))

write.table(summaryData, file = "summaryData.txt", row.name=FALSE)
