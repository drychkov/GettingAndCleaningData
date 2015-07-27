# Codebook

## Project Description
This is a codebook for the course project "Getting and Cleaning Data"

##Collection of the raw data
The data was downloaded from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones and unzipped.
The link to the data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

##Creating the tidy datafile

###Guide to create the tidy data file
1. download the data
2. unzip
3. read features names from ./UCI HAR Dataset/features.txt
4. add "SubjectId" and "Activity" to the list of features
5. collect activity data table from ./UCI HAR Dataset/activity_labels.txt
6. read 3 train datasets from ./UCI HAR Dataset/train and combine into one
7. read 3 test datasets from ./UCI HAR Dataset/test and combine into one
8. combine train and test datasets into one
9. name features for the result from the list of step 4
10. remove dublicates in features
11. filter features only with mean() and std(). Features with meanFreq() were removed because they weighted averages of the frequency components. We are interested only in unweighted means. Features angle() that contained mean/std values in arguments were also removed. They do not represent a mean/std value of a measurement. 
12. rename numbers in "Activity" by activity names from the list of step 5
13. label the data set with descriptive variable names:
-mean -> Mean, 
-std -> Std, 
JerkMag -> JerkMagnitude, 
AcckMag -> AcckMagnitude, 
GyroMag -> GyroMagnitude, 
t -> time, 
f -> freq
14. create a dataset with the average of each variable for each activity and each subject
15. write result into txt file


##Description of the variables in the summaryData.txt file
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals timeAcc-XYZ and timeGyro-XYZ. The acceleration signal was then separated into body and gravity acceleration signals (BodyAcc and GravityAcc). Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals. Also the magnitude of these three-dimensional signals were calculated. A Fast Fourier Transform (FFT) was applied to some of these signals producing (freq).

Mean: Mean value,

Std: Standard deviation
