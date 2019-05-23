# UCI HAR Project - README 

> Course Project is final assignment of Coursera course (part of upskilling training path of data analyst in BNPP)

> Project is based on experiments "carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data". (extract from  UCI HAR ReadMe.txt)

> This README describe variables, data and transformations that have been performed to: 
  - Collect & check data from the site 
  - Merges the training and the test sets to create one data set
  - Extracts only the measurements on the mean and standard deviation for each measurement.
  - Uses descriptive activity names to name the activities in the data set
  - Appropriately labels the data set with descriptive variable names.
  - From the data set in previous step , creates a second, independent tidy data set with the average of each variable for each activity and each subject.

A R script (run_analysis.R) has been created to performe assignment results. 
Following all work step by step done  to solve problem 

==================================================================
> N.B. run_analysis function takes ad arguments the name of the root folder "UCI HAR Dataset"
==================================================================


  > Assign 1. Collect & check data from the site 

1. Setting up local folder and download data for the project from [URL Address][URL1].  In order to reproduce all steps, controls habe to be performed to manage errors 

         # Check if zipfile has been already 1) dowloaded and 2)unzipped : iIF NOT,download & unzip 
         if(!file.exists(sourceDataFolder))  {
                #  zip file exists? IF NOT, downlod it
           if(!file.exists(zipFilename))            { 
              zipFileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
              download.file(zipFileUrl, zipFilename)
           } 
           unzip(zipFilename)
       }
2. Listing & checking unzipped files
 Zip file contents:
    - activities_label.txt : humain activities coded (1-WALKING, 2- WALKING_UPSTAIRS, 3-WALKING_DOWNSTAIRS, 4-SITTING, 5-STANDING, 6-LAYING) 
    - features.txt :  type of  measurements taken by sensor signals (accelerometer and gyroscope 3-axial) - 561 different types of measurements including mean, standard deviation, median, max & min value in array. All details are illustrated in "features.info.txt"
     - train folder : with results people participanting to training (' subject_train.txt' subjects=21 volunteers : with code 1-3-5-6-7-8-11-14-15-16-17-19-21-22-23-25-26-27-28-29-30)  + recorded features / activities for training ('X_train.txt'/'Y_train.txt'). Others files in train/Inertial Signals folder are not used in the project 
    - test folder : with results  people participanting to test (' subject_train.txt' subjects= 9 volunteers : with code 2-4-9-10-12-13-18-20-24)  + recorded features / activities for test ('X_test.txt'/'Y_test.txt'). Others files in test/Inertial Signals folder are not used in the project 
  
 
  >  Assign 2. Merges the training and the test sets to create one data set  
1. Reading files and assigning data to dataframe
           
         # Reading data from train folder files & assign to dataframes
        trainFeatures   <- read.table(paste(sourceDataFolder, 'train', 'X_train.txt',sep="/"))
        trainActivities <- read.table(file.path(sourceDataFolder, 'train', 'y_train.txt'))
        trainSubjects   <- read.table(file.path(sourceDataFolder, 'train', 'subject_train.txt'))
          # Reading data from test  folder files & assign to dataframes 
        testFeatures    <- read.table(file.path(sourceDataFolder, 'test', 'X_test.txt'))
        testActivities  <- read.table(file.path(sourceDataFolder, 'test', 'y_test.txt'))
        testSubjects    <- read.table(file.path(sourceDataFolder, 'test', 'subject_test.txt'))
         # using rbind() to bind the rows of data sets 
        bindFeatures <- rbind(trainFeatures, testFeatures)
        bindActivities <- rbind(trainActivities, testActivities)
        bindSubjects <- rbind(trainSubjects, testSubjects)
         # using cbind() to bind different columns together and a merged table results
        bindAllData <- cbind(bindSubjects,bindActivities,bindFeatures)

    'bindAllData' is a dataframe  with 10299 obs. of  1123 variables ( details via str(bindAllData))

  
> Assign 3. Extracts only the measurements on the mean and standard deviation for each measurement  
  1. Reading list of features and grep features 'mean' and 'std' (all occurences in features column names)
  
          features <- read.table(paste(sourceDataFolder, 'features.txt',sep="/"))
          meanStdFeatures <- features[grep('-([Mm]ean|[Ss]td)', features[, 2 ]), 2]
  
  2.  Subsetting 'bindAllData' to create a new dataframe, 'bindAllDataMS', with mean & std measurements 
    
            bindAllDataMS <- bindAllData[, c(1, 2, meanStdFeatures)]
 
 > Assign 4. Uses descriptive activity names to name the activities in the data set
  1. Reading activity labels and replace activity code with corrispondent label (2nd column of 'bindAllDataMS')
    
         activities <- read.table(paste(sourceDataFolder, 'activity_labels.txt',sep="/"))
         bindAllDataMS[, 2] <- activities[bindAllDataMS[,2], 2]
 
 > Assign 5.  Appropriately labels the data set with descriptive variable names
1. Assigning as columns names  meanStdFeatures columns names and 2. replacing Vxxx colnames
    
            colnames(bindAllDataMS) <- c(as.character(meanStdFeatures))
    
2. Assigning  'Volunteer' at  1st col name , 'Activity'  at 2nd col 
    
        names(bindAllDataMS)[1] <- "Volunteer"
        names(bindAllDataMS)[2] <- "Activity"

3. Using gsub() to replacing recursively in all columns names  all starts with t with Time and f with Frequency 

        names(bindAllDataMS)    <- gsub("^t", "Time",names(bindAllDataMS))
        names(bindAllDataMS)    <- gsub("^f", "Frequency",names(bindAllDataMS))
        names(bindAllDataMS)    <- gsub("std", "Std",names(bindAllDataMS))
        names(bindAllDataMS)    <- gsub("mean", "Mean",names(bindAllDataMS))
        names(bindAllDataMS)    <- gsub("mean", "Mean",names(bindAllDataMS))



 4. Eliminating () and - in all columns names
          
          names(bindAllDataMS)    <- gsub('\\-|\\(|\\)', '', names(bindAllDataMS))
  
 
 
 > Assign5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
1. Creating  new tidy dataframe 'tidyAllDataMean' with average of each variable for each volunteer and each activity  
    
        tidyAllDataMean <- aggregate(. ~Volunteer + Activity, bindAllDataMS, mean)
        tidyAllDataMean <- tidyAllDataMean[order(tidyAllDataMean$Volunteer, tidyAllDataMean$Activity),]

    'tidyAllDataMean' is a dataframe of 180 obs. of  80 variables ( details via str(tidyAllDataMean))
2. Writing dataframe 'tidyAllDataMean' into tidyData.txt
     
        write.table(tidyAllDataMean, file=paste(dataFolder,("tidyData.txt"),sep="/"), row.names = FALSE)

    Resulting tidyData.txt is a 256K file.


   [URL1]: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>


