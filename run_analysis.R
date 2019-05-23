run_analysis <- function(dataFolder)
{
  
  # Initialize path values
  sourceDataFolder <- dataFolder
  zipFilename <- 'getdata_projectfiles_UCI HAR Dataset.zip'
  
  # Check if zipfile has been already 1) dowloaded and 2)unzipped : iIF NOT,download & unzip 
  if(!file.exists(sourceDataFolder)) 
  {
    
    #  zip file exists? IF NOT, downlod it
    if(!file.exists(zipFilename)) 
    { 
      zipFileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
      download.file(zipFileUrl, zipFilename)
    }
    unzip(zipFilename)
  }
  
  
  
  # 1. Merges the training and the test sets to create one data set.
  
  # Reading data from train folder files & assign to dataframes
  
  trainFeatures   <- read.table(paste(sourceDataFolder, 'train', 'X_train.txt',sep="/"))
  trainActivities <- read.table(paste(sourceDataFolder, 'train', 'y_train.txt',sep="/"))
  trainSubjects   <- read.table(paste(sourceDataFolder, 'train', 'subject_train.txt',sep="/"))
  
  # Reading data from test  folder files & assign to dataframes 
  testFeatures    <- read.table(paste(sourceDataFolder, 'test', 'X_test.txt',sep="/"))
  testActivities  <- read.table(paste(sourceDataFolder, 'test', 'y_test.txt',sep="/"))
  testSubjects    <- read.table(paste(sourceDataFolder, 'test', 'subject_test.txt',sep="/"))
  
  # using rbind() to bind the rows of data sets 
  bindFeatures <- rbind(trainFeatures, testFeatures)
  bindActivities <- rbind(trainActivities, testActivities)
  bindSubjects <- rbind(trainSubjects, testSubjects)
  
  # using cbind() to bind different columns together and have a merged table resulting
  bindAllData <- cbind(bindSubjects, bindActivities, bindFeatures)
  
  #### ASSIGNEMENT  2. Extracts only the measurements on the mean and standard deviation for each measurement  
  
  # Reading list of features and grep features 'mean' and 'std' (all occurences in features column names)
  features <- read.table(paste(sourceDataFolder, 'features.txt',sep="/"))
  meanStdFeatures <- features[grep('-([Mm]ean|[Ss]td)', features[, 2 ]), 2]
  
  # Creating a new df with mena/std subsetting bindAllData
  bindAllDataMS <- bindAllData[, c(1, 2, meanStdFeatures)]
  
  
  #### ASSIGNEMENT  3. Uses descriptive activity names to name the activities in the data set
  
  # Read activity labels and replace activity code with corrispondent label (2nd column)
  activities <- read.table(paste(sourceDataFolder, 'activity_labels.txt',sep="/"))
  bindAllDataMS[, 2] <- activities[bindAllDataMS[,2], 2]
  
  
  
  #### ASSIGNEMENT  4. Appropriately labels the data set with descriptive variable names. 
  
  # assigning as columns names  meanStdFeatures columns names and replacing Vxxx colnames
  colnames(bindAllDataMS) <- c(as.character(meanStdFeatures))
  
  # assigning  Volunteer at  1st col name , activity  at 2nd col 
  # with gsub() recursively in all columns names replace of all start with t with Time and f with Frequency 
  # eliminating () and - in all columns names
  names(bindAllDataMS)[1] <- "Volunteer"
  names(bindAllDataMS)[2] <- "Activity"
  names(bindAllDataMS)    <- gsub("^t", "Time",names(bindAllDataMS))
  names(bindAllDataMS)    <- gsub("^f", "Frequency",names(bindAllDataMS))
  names(bindAllDataMS)    <- gsub("std", "Std",names(bindAllDataMS))
  names(bindAllDataMS)    <- gsub("mean", "Mean",names(bindAllDataMS))
  names(bindAllDataMS)    <- gsub("mean", "Mean",names(bindAllDataMS))
  names(bindAllDataMS)    <- gsub('\\-|\\(|\\)', '', names(bindAllDataMS))
  
  
  #### ASSIGNEMENT  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
  # creating a new tidy dataframe with "mean" values
  tidyAllDataMean <- aggregate(. ~Volunteer + Activity, bindAllDataMS, mean)
  tidyAllDataMean <- tidyAllDataMean[order(tidyAllDataMean$Volunteer, tidyAllDataMean$Activity),]
  
  print(str(tidyAllDataMean))
  
  # writing dataframe into a file
  write.table(tidyAllDataMean, file=paste(dataFolder,("tidyData.txt"),sep="/"), row.names = FALSE)
  
}