# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
# The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers 
# on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set 
# as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) 
# a code book that describes the variables, the data, and any transformations or work that you performed to 
# clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. 
# This repo explains how all of the scripts work and how they are connected.  
#
# One of the most exciting areas in all of data science right now is wearable computing - see for example  
# this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms
# to attract new users. The data linked to from the course website represent data collected from the accelerometers 
# from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
#   
#  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# 
# Here are the data for the project: 
#   
#  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#
# You should create one R script called run_analysis.R that does the following. 
# 1.Merges the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names. 
# 5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
#setwd("D:/XXX/getting and cleaning data/exam)

# Create a folder to save the zip file on it
if (!file.exists("./data")) {dir.create("./data")}
zipUrl= "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile = "./data/data.zip"
download.file (zipUrl, destfile=zipFile, method="auto")

# Unzip the file
unzip (zipFile)

# As a result, on the root there will be a new directory called UCI HAR Dataset and inside it there will
# be two folders called test and train with all the files we will use to make the merge
#setwd("D:/XXXX/getting and cleaning data/exam/UCI HAR Dataset")
setwd("./UCI HAR Dataset")

# Now we will merge the information of the subject, activity and results. 
# And we will do it for the train and for the test
subject_train = read.csv ("./train/subject_train.txt",header=F, col.names="subject");
x_train <- read.table ("./train/X_train.txt",comment.char = "",colClasses="numeric");
y_train = read.csv ("./train/y_train.txt",header=F, col.names="activity");
train <- cbind (subject_train, y_train,x_train)

subject_test  = read.csv ("./test/subject_test.txt",header=F, col.names="subject");
x_test <- read.table ("./test/X_test.txt",comment.char = "",colClasses="numeric");
y_test = read.csv ("./test/y_test.txt",header=F, col.names="activity");
test <- cbind (subject_test, y_test,x_test )

# 1.Merges the training and the test sets to create one data set.
# To join two data frames (datasets) vertically, use the rbind function. 
# The two data frames must have the same variables, but they do not have to be in the same order
mergedData <- rbind(train, test) 

# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# If you take a look at the features.txt file, you will find what we need to extract. As we have also 
# at the begining of each line the subject and the analysis, we have to add 2 to each number 
# to get the correct position
#1 tBodyAcc-mean()-X
#2 tBodyAcc-mean()-Y
#3 tBodyAcc-mean()-Z
#4 tBodyAcc-std()-X
#5 tBodyAcc-std()-Y
#6 tBodyAcc-std()-Z
#41 tGravityAcc-mean()-X
#42 tGravityAcc-mean()-Y
#43 tGravityAcc-mean()-Z
#44 tGravityAcc-std()-X
#45 tGravityAcc-std()-Y
#46 tGravityAcc-std()-Z
#81 tBodyAccJerk-mean()-X
#82 tBodyAccJerk-mean()-Y
#83 tBodyAccJerk-mean()-Z
#84 tBodyAccJerk-std()-X
#85 tBodyAccJerk-std()-Y
#86 tBodyAccJerk-std()-Z
#121 tBodyGyro-mean()-X
#122 tBodyGyro-mean()-Y
#123 tBodyGyro-mean()-Z
#124 tBodyGyro-std()-X
#125 tBodyGyro-std()-Y
#126 tBodyGyro-std()-Z
#161 tBodyGyroJerk-mean()-X
#162 tBodyGyroJerk-mean()-Y
#163 tBodyGyroJerk-mean()-Z
#164 tBodyGyroJerk-std()-X
#165 tBodyGyroJerk-std()-Y
#166 tBodyGyroJerk-std()-Z
#201 tBodyAccMag-mean()
#202 tBodyAccMag-std()
#214 tGravityAccMag-mean()
#215 tGravityAccMag-std()
#227 tBodyAccJerkMag-mean()
#228 tBodyAccJerkMag-std()
#240 tBodyGyroMag-mean()
#241 tBodyGyroMag-std()
#253 tBodyGyroJerkMag-mean()
#254 tBodyGyroJerkMag-std()
#266 fBodyAcc-mean()-X
#267 fBodyAcc-mean()-Y
#268 fBodyAcc-mean()-Z
#269 fBodyAcc-std()-X
#270 fBodyAcc-std()-Y
#271 fBodyAcc-std()-Z
#345 fBodyAccJerk-mean()-X
#346 fBodyAccJerk-mean()-Y
#347 fBodyAccJerk-mean()-Z
#348 fBodyAccJerk-std()-X
#349 fBodyAccJerk-std()-Y
#350 fBodyAccJerk-std()-Z
#424 fBodyGyro-mean()-X
#425 fBodyGyro-mean()-Y
#426 fBodyGyro-mean()-Z
#427 fBodyGyro-std()-X
#428 fBodyGyro-std()-Y
#429 fBodyGyro-std()-Z
#503 fBodyAccMag-mean()
#504 fBodyAccMag-std()
#516 fBodyBodyAccJerkMag-mean()
#517 fBodyBodyAccJerkMag-std()
#529 fBodyBodyGyroMag-mean()
#530 fBodyBodyGyroMag-std()
#542 fBodyBodyGyroJerkMag-mean()
#543 fBodyBodyGyroJerkMag-std()
df<-mergedData[,c("subject","activity","V3","V4","V5","V6","V7","V8","V43","V44","V45","V46","V47","V48","V83","V84","V85",
         "V86","V87","V88","V123","V124","V125","V126","V127","V128","V163","V164","V165","V166","V167","V168",
         "V203","V204","V216","V217","V229","V230","V242","V243","V255","V256","V268","V269","V270","V271","V272",
         "V273","V347","V348","V349","V350","V351","V352","V426","V427","V428","V429","V430","V431","V505","V506",
         "V518","V519","V531","V532","V544","V545")]

# 3.Uses descriptive activity names to name the activities in the data set
df$activity[df$activity == 1] <- "WALKING"
df$activity[df$activity == 2] <- "WALKING_UPSTAIRS"
df$activity[df$activity == 3] <- "WALKING_DOWNSTAIRS"
df$activity[df$activity == 4] <- "SITTING"
df$activity[df$activity == 5] <- "STANDING"
df$activity[df$activity == 6] <- "LAYING"

# 4.Appropriately labels the data set with descriptive variable names. 
arr_cols <- c("subject", "activity", 
              "tBodyAcc_mean_X","tBodyAcc_mean_Y","tBodyAcc_mean_Z",
              "tBodyAcc_std_X","tBodyAcc_std_Y","tBodyAcc_std_Z",
              "tGravityAcc_mean_X","tGravityAcc_mean_Y","tGravityAcc_mean_Z",
              "tGravityAcc_std_X","tGravityAcc_std_Y","tGravityAcc_std_Z",
              "tBodyAccJerk_mean_X","tBodyAccJerk_mean_Y","tBodyAccJerk_mean_Z",
              "tBodyAccJerk_std_X","tBodyAccJerk_std_Y","tBodyAccJerk_std_Z",
              "tBodyGyro_mean_X","tBodyGyro_mean_Y","tBodyGyro_mean_Z",
              "tBodyGyro_std_X","tBodyGyro_std_Y","tBodyGyro_std_Z"
              ,"tBodyGyroJerk_mean_X","tBodyGyroJerk_mean_Y","tBodyGyroJerk_mean_Z","tBodyGyroJerk_std_X"
              ,"tBodyGyroJerk_std_Y","tBodyGyroJerk_std_Z","tBodyAccMag_mean","tBodyAccMag_std","tGravityAccMag_mean"
              ,"tGravityAccMag_std","tBodyAccJerkMag_mean","tBodyAccJerkMag_std","tBodyGyroMag_mean"
              ,"tBodyGyroMag_std","tBodyGyroJerkMag_mean","tBodyGyroJerkMag_std","fBodyAcc_mean_X"
              ,"fBodyAcc_mean_Y","fBodyAcc_mean_Z","fBodyAcc_std_X","fBodyAcc_std_Y","fBodyAcc_std_Z"
              ,"fBodyAccJerk_mean_X","fBodyAccJerk_mean_Y","fBodyAccJerk_mean_Z","fBodyAccJerk_std_X"
              ,"fBodyAccJerk_std_Y","fBodyAccJerk_std_Z","fBodyGyro_mean_X","fBodyGyro_mean_Y","fBodyGyro_mean_Z"
              ,"fBodyGyro_std_X","fBodyGyro_std_Y","fBodyGyro_std_Z"              
              ,"fBodyAccMag_mean","fBodyAccMag_std","fBodyBodyAccJerkMag_mean","fBodyBodyAccJerkMag_std"
              ,"fBodyBodyGyroMag_mean","fBodyBodyGyroMag_std","fBodyBodyGyroJerkMag_mean"
              ,"fBodyBodyGyroJerkMag_std")

for (i in 3:length(arr_cols)){
  names (df)[i] <-arr_cols[i]
}

# 5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
aux<-  aggregate(df$tBodyAcc_mean_X, list(subject = df$subject, activity = df$activity), mean)
result <- aux
aux<-  aggregate(df$tBodyAcc_mean_Y, list(subject = df$subject, activity = df$activity), mean)
result["tBodyAcc_mean_Y"] <- aux["x"]
aux<-  aggregate(df$tBodyAcc_mean_Z, list(subject = df$subject, activity = df$activity), mean)
result["tBodyAcc_mean_Z"] <- aux["x"]
aux<-  aggregate(df$tBodyAcc_std_X, list(subject = df$subject, activity = df$activity), mean)
result["tBodyAcc_std_X"] <- aux["x"]
aux<-  aggregate(df$tBodyAcc_std_Y, list(subject = df$subject, activity = df$activity), mean)
result["tBodyAcc_std_Y"] <- aux["x"]
aux<-  aggregate(df$tBodyAcc_std_Z, list(subject = df$subject, activity = df$activity), mean)
result["tBodyAcc_std_Z"] <- aux["x"]
aux<-  aggregate(df$tGravityAcc_mean_X, list(subject = df$subject, activity = df$activity), mean)
result["tGravityAcc_mean_X"] <- aux["x"]
aux<-  aggregate(df$tGravityAcc_mean_Y, list(subject = df$subject, activity = df$activity), mean)
result["tGravityAcc_mean_Y"] <- aux["x"]
aux<-  aggregate(df$tGravityAcc_mean_Z, list(subject = df$subject, activity = df$activity), mean)
result["tGravityAcc_mean_Z"] <- aux["x"]
aux<-  aggregate(df$tGravityAcc_std_X, list(subject = df$subject, activity = df$activity), mean)
result["tGravityAcc_std_X"] <- aux["x"]
aux<-  aggregate(df$tGravityAcc_std_Y, list(subject = df$subject, activity = df$activity), mean)
result["tGravityAcc_std_Y"] <- aux["x"]  
aux<-  aggregate(df$tGravityAcc_std_Z, list(subject = df$subject, activity = df$activity), mean)
result["tGravityAcc_std_Z"] <- aux["x"]
aux<-  aggregate(df$tBodyAccJerk_mean_X, list(subject = df$subject, activity = df$activity), mean)
result["tBodyAccJerk_mean_X"] <- aux["x"]
aux<-  aggregate(df$tBodyAccJerk_mean_Y, list(subject = df$subject, activity = df$activity), mean)
result["tBodyAccJerk_mean_Y"] <- aux["x"]
aux<-  aggregate(df$tBodyAccJerk_mean_Z, list(subject = df$subject, activity = df$activity), mean)
result["tBodyAccJerk_mean_Z"] <- aux["x"]
aux<-  aggregate(df$tBodyAccJerk_std_X, list(subject = df$subject, activity = df$activity), mean)
result["tBodyAccJerk_std_X"] <- aux["x"]
aux<-  aggregate(df$tBodyAccJerk_std_Y, list(subject = df$subject, activity = df$activity), mean)
result["tBodyAccJerk_std_Y"] <- aux["x"]
aux<-  aggregate(df$tBodyAccJerk_std_Z, list(subject = df$subject, activity = df$activity), mean)
result["tBodyAccJerk_std_Z"] <- aux["x"]
aux<-  aggregate(df$tBodyGyro_mean_X, list(subject = df$subject, activity = df$activity), mean)
result["tBodyGyro_mean_X"] <- aux["x"]
aux<-  aggregate(df$tBodyGyro_mean_Y, list(subject = df$subject, activity = df$activity), mean)
result["tBodyGyro_mean_Y"] <- aux["x"]
aux<-  aggregate(df$tBodyGyro_mean_Z, list(subject = df$subject, activity = df$activity), mean)
result["tBodyGyro_mean_Z"] <- aux["x"]
aux<-  aggregate(df$tBodyGyro_std_X, list(subject = df$subject, activity = df$activity), mean)
result["tBodyGyro_std_X"] <- aux["x"]
aux<-  aggregate(df$tBodyGyro_std_Y, list(subject = df$subject, activity = df$activity), mean)
result["tBodyGyro_std_Y"] <- aux["x"]
aux<-  aggregate(df$tBodyGyro_std_Z, list(subject = df$subject, activity = df$activity), mean)
result["tBodyGyro_std_Z"] <- aux["x"]  
aux<-  aggregate(df$tBodyGyroJerk_mean_X, list(subject = df$subject, activity = df$activity), mean)
result["tBodyGyroJerk_mean_X"] <- aux["x"]
aux<-  aggregate(df$tBodyGyroJerk_mean_Y, list(subject = df$subject, activity = df$activity), mean)
result["tBodyGyroJerk_mean_Y"] <- aux["x"]
aux<-  aggregate(df$tBodyGyroJerk_mean_Z, list(subject = df$subject, activity = df$activity), mean)
result["tBodyGyroJerk_mean_Z"] <- aux["x"]
aux<-  aggregate(df$tBodyGyroJerk_std_X, list(subject = df$subject, activity = df$activity), mean)
result["tBodyGyroJerk_std_X"] <- aux["x"]
aux<-  aggregate(df$tBodyGyroJerk_std_Y, list(subject = df$subject, activity = df$activity), mean)
result["tBodyGyroJerk_std_Y"] <- aux["x"]
aux<-  aggregate(df$tBodyGyroJerk_std_Z, list(subject = df$subject, activity = df$activity), mean)
result["tBodyGyroJerk_std_Z"] <- aux["x"]
aux<-  aggregate(df$tBodyAccMag_mean, list(subject = df$subject, activity = df$activity), mean)
result["tBodyAccMag_mean"] <- aux["x"]
aux<-  aggregate(df$tBodyAccMag_std, list(subject = df$subject, activity = df$activity), mean)
result["tBodyAccMag_std"] <- aux["x"]
aux<-  aggregate(df$tGravityAccMag_mean, list(subject = df$subject, activity = df$activity), mean)
result["tGravityAccMag_mean"] <- aux["x"]
aux<-  aggregate(df$tGravityAccMag_std, list(subject = df$subject, activity = df$activity), mean)
result["tGravityAccMag_std"] <- aux["x"]
aux<-  aggregate(df$tBodyAccJerkMag_mean, list(subject = df$subject, activity = df$activity), mean)
result["tBodyAccJerkMag_mean"] <- aux["x"]
aux<-  aggregate(df$tBodyAccJerkMag_std, list(subject = df$subject, activity = df$activity), mean)
result["tBodyAccJerkMag_std"] <- aux["x"]
aux<-  aggregate(df$tBodyGyroMag_mean, list(subject = df$subject, activity = df$activity), mean)
result["tBodyGyroMag_mean"] <- aux["x"]
aux<-  aggregate(df$tBodyGyroMag_std, list(subject = df$subject, activity = df$activity), mean)
result["tBodyGyroMag_std"] <- aux["x"]
aux<-  aggregate(df$tBodyGyroJerkMag_mean, list(subject = df$subject, activity = df$activity), mean)
result["tBodyGyroJerkMag_mean"] <- aux["x"]
aux<-  aggregate(df$tBodyGyroJerkMag_std, list(subject = df$subject, activity = df$activity), mean)
result["tBodyGyroJerkMag_std"] <- aux["x"]
aux<-  aggregate(df$fBodyAcc_mean_X, list(subject = df$subject, activity = df$activity), mean)
result["fBodyAcc_mean_X"] <- aux["x"]
aux<-  aggregate(df$fBodyAcc_mean_Y, list(subject = df$subject, activity = df$activity), mean)
result["fBodyAcc_mean_Y"] <- aux["x"]
aux<-  aggregate(df$fBodyAcc_mean_Z, list(subject = df$subject, activity = df$activity), mean)
result["fBodyAcc_mean_Z"] <- aux["x"]
aux<-  aggregate(df$fBodyAcc_std_X, list(subject = df$subject, activity = df$activity), mean)
result["fBodyAcc_std_X"] <- aux["x"]
aux<-  aggregate(df$fBodyAcc_std_Y, list(subject = df$subject, activity = df$activity), mean)
result["fBodyAcc_std_Y"] <- aux["x"]
aux<-  aggregate(df$fBodyAcc_std_Z, list(subject = df$subject, activity = df$activity), mean)
result["fBodyAcc_std_Z"] <- aux["x"]
aux<-  aggregate(df$fBodyAccJerk_mean_X, list(subject = df$subject, activity = df$activity), mean)
result["fBodyAccJerk_mean_X"] <- aux["x"]
aux<-  aggregate(df$fBodyAccJerk_mean_Y, list(subject = df$subject, activity = df$activity), mean)
result["fBodyAccJerk_mean_Y"] <- aux["x"]
aux<-  aggregate(df$fBodyAccJerk_mean_Z, list(subject = df$subject, activity = df$activity), mean)
result["fBodyAccJerk_mean_Z"] <- aux["x"]
aux<-  aggregate(df$fBodyAccJerk_std_X, list(subject = df$subject, activity = df$activity), mean)
result["fBodyAccJerk_std_X"] <- aux["x"]
aux<-  aggregate(df$fBodyAccJerk_std_Y, list(subject = df$subject, activity = df$activity), mean)
result["fBodyAccJerk_std_Y"] <- aux["x"]
aux<-  aggregate(df$fBodyAccJerk_std_Z, list(subject = df$subject, activity = df$activity), mean)
result["fBodyAccJerk_std_Z"] <- aux["x"]
aux<-  aggregate(df$fBodyGyro_mean_X, list(subject = df$subject, activity = df$activity), mean)
result["fBodyGyro_mean_X"] <- aux["x"]
aux<-  aggregate(df$fBodyGyro_mean_Y, list(subject = df$subject, activity = df$activity), mean)
result["fBodyGyro_mean_Y"] <- aux["x"]
aux<-  aggregate(df$fBodyGyro_mean_Z, list(subject = df$subject, activity = df$activity), mean)
result["fBodyGyro_mean_Z"] <- aux["x"]
aux<-  aggregate(df$fBodyGyro_std_X, list(subject = df$subject, activity = df$activity), mean)
result["fBodyGyro_std_X"] <- aux["x"]
aux<-  aggregate(df$fBodyGyro_std_Y, list(subject = df$subject, activity = df$activity), mean)
result["fBodyGyro_std_Y"] <- aux["x"]
aux<-  aggregate(df$fBodyGyro_std_Z, list(subject = df$subject, activity = df$activity), mean)
result["fBodyGyro_std_Z"] <- aux["x"]
aux<-  aggregate(df$fBodyAccMag_mean, list(subject = df$subject, activity = df$activity), mean)
result["fBodyAccMag_mean"] <- aux["x"]
aux<-  aggregate(df$fBodyAccMag_std, list(subject = df$subject, activity = df$activity), mean)
result["fBodyAccMag_std"] <- aux["x"]
aux<-  aggregate(df$fBodyBodyAccJerkMag_mean, list(subject = df$subject, activity = df$activity), mean)
result["fBodyBodyAccJerkMag_mean"] <- aux["x"]
aux<-  aggregate(df$fBodyBodyAccJerkMag_std, list(subject = df$subject, activity = df$activity), mean)
result["fBodyBodyAccJerkMag_std"] <- aux["x"]
aux<-  aggregate(df$fBodyBodyGyroMag_mean, list(subject = df$subject, activity = df$activity), mean)
result["fBodyBodyGyroMag_mean"] <- aux["x"]
aux<-  aggregate(df$fBodyBodyGyroMag_std, list(subject = df$subject, activity = df$activity), mean)
result["fBodyBodyGyroMag_std"] <- aux["x"]
aux<-  aggregate(df$fBodyBodyGyroJerkMag_mean, list(subject = df$subject, activity = df$activity), mean)
result["fBodyBodyGyroJerkMag_mean"] <- aux["x"]
aux<-  aggregate(df$fBodyBodyGyroJerkMag_std, list(subject = df$subject, activity = df$activity), mean)
result["fBodyBodyGyroJerkMag_std"] <- aux["x"]

write.table(df, "../tidy_data.txt", sep="\t") 
write.table(result, "../result_mean.txt", sep="\t") 

