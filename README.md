getting_and_cleaning_data
=========================

Course Project: Getting and Cleaning Data

On the run_analysis.R file, you will have a small demo on how you can download a zip file from internet and process its information. 
Instead of working with the downloaded data over a selected folder, I have added a small script to download the data from Internet. If you have the information on your computer, you can avoid that part of the script. 

Once you have the zip file, it will be unziped on the root folder of your working directory, so I move to the directory called UCI HAR Dataset using the command setwd("./UCI HAR Dataset") 

If you have the files downloaded, you can avoid this part of the script. 

From this point, what the script needs is two folders train and test containing each of them three files. With these files, I merge them to create a new datasets (one for train and another one for test). 

1. After that I do the merge usind the command
mergedData <- rbind(train, test) 

2. With the mergind data, the script extracts the information of the mean and std. If you take a look at the features.txt file from the unzip folder, you will find what we need to extract. As we have also at the beginning of each line the subject and the analysis, we have to add 2 to each number to get the correct position.

Now we have a data frame with only the selected columns. 

3. Reading the information from the .txt file, I have taken the description of each activity to rename the information on the dataframe. 
4. We make a loop to set the appropriate labels the data set with descriptive variable names. 
5. I have created a second, independent tidy data set with the average of each variable for each activity and each subject. I have not been able to do it on a loop, so it can be improved. 
 
Finally, I create to txt files, one with the dataframe and another one with the tidy_data



