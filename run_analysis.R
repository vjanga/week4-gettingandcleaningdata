#Assuming user of the script had downloaded the data set and extracted it to a folder called UCI_HAR_Dataset
#Here we load data in to variables from files for further processing
feature<-read.table("./UCI_HAR_Dataset/features.txt",header = FALSE)
activity_label<-read.table("./UCI_HAR_Dataset/activity_labels.txt",header = FALSE)


train_data <- data.frame(read.table("./UCI_HAR_Dataset/train/X_train.txt"))
train_activity <- data.frame(read.table("./UCI_HAR_Dataset/train/y_train.txt"))
#step3 is getting taken care here as I thought its less data to process and less burden on system
train_activity$V1 <- factor(train_activity$V1,levels = activity_label$V1,labels = activity_label$V2)
train_subject <- data.frame(read.table("./UCI_HAR_Dataset/train/subject_train.txt"))

test_data <- data.frame(read.table("./UCI_HAR_Dataset/test/X_test.txt"))
test_activity <- data.frame(read.table("./UCI_HAR_Dataset/test/y_test.txt"))
#step3 is getting taken care here as I thought its less data to process and less burden on system
test_activity$V1 <- factor(test_activity$V1,levels = activity_label$V1,labels = activity_label$V2)
test_subject <- data.frame(read.table("./UCI_HAR_Dataset/test/subject_test.txt"))


names(train_data) <- feature$V2
names(train_activity) <- "activity_id"
names(train_subject) <- "subject_id"

#Adding subject id and activity_id to training data set
train_data <- cbind(train_subject,train_activity,train_data)


names(test_data) <- feature$V2
names(test_activity) <- "activity_id"
names(test_subject) <- "subject_id"

#Adding subject id and activity_id to test data set
test_data <- cbind(test_subject,test_activity,test_data)


#Step1 : Merge two data sets here
data_set <- rbind(train_data,test_data)

#Step2 : Extract mean and std only measurments

data_set<-data_set[,grepl("subject_id|std|mean|activity_id",names(data_set))]
data_set<-data_set[,names(select(data_set,-matches("meanFreq")))]

#Set4 : Renaming the lables with appropriate names for the variables.

names(data_set) <- gsub("tBodyAcc-","Time domain body acceleration signal's ",names(data_set))
names(data_set) <- gsub("tGravityAcc-","Time domain gravity acceleration signal's ",names(data_set))
names(data_set) <- gsub("tBodyAccJerk-","Time domain body acceleration jerk signal's ",names(data_set))
names(data_set) <- gsub("tBodyGyro-","Time domain body gyroscope signal's ",names(data_set))
names(data_set) <- gsub("tBodyGyroJerk-","Time domain body gyroscope jerk signal's ",names(data_set))
names(data_set) <- gsub("tBodyAccMag-","Time domain body acceleration magnitude signal's ",names(data_set))
names(data_set) <- gsub("tGravityAccMag-","Time domain gravity acceleration magnitude signal's ",names(data_set))
names(data_set) <- gsub("tBodyAccJerkMag-","Time domain body acceleration jerk magnitude signal's ",names(data_set))
names(data_set) <- gsub("tBodyGyroMag-","Time domain body gyroscope magnitude signal's ",names(data_set))
names(data_set) <- gsub("tBodyGyroJerkMag-","Time domain body gyroscope jerk magnitude signal's ",names(data_set))
names(data_set) <- gsub("fBodyAcc-","Frequency domain body acceleration signal's ",names(data_set))
names(data_set) <- gsub("fBodyAccJerk-","Frequency domain body acceleration jerk signal's ",names(data_set))
names(data_set) <- gsub("fBodyGyro-","Frequency domain body gyroscope signal's ",names(data_set))
names(data_set) <- gsub("fBodyAccMag-","Frequency domain body acceleration magnitude signal's ",names(data_set))
names(data_set) <- gsub("fBodyBodyAccJerkMag-","Frequency domain body acceleration jerk magnitude signal's ",names(data_set))
names(data_set) <- gsub("fBodyBodyGyroMag-","Frequency domain body gyroscope magnitude signal's ",names(data_set))
names(data_set) <- gsub("fBodyBodyGyroJerkMag-","Frequency domain body gyroscope jerk magnitude signal's ",names(data_set))


#Step5: finally calaculte average for all variable for subject for activity.
tidied_data_set <- data_set %>%
  group_by(subject_id,activity_id) %>%
  summarise_all(mean)

#Finally write the data to a file
write.table(tidied_data_set,"tidydata.txt",row.names = FALSE)