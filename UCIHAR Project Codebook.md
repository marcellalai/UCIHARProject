
UCI HAR Project - Codebook

Course Project is final assignment of Coursera course (part of upskilling training path of data analyst in BNPP)
Project is based on
===================================================================================
"Human Activity Recognition (HAR) database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors
Authors: Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory - DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy - www.smartlab.ws
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data". (extract from ReadMe.txt)
===================================================================================

Project has to perfoms following activies

    Collect & check data from the site
    Merges the training and the test sets to create one data set
    Extracts only the measurements on the mean and standard deviation for each measurement.
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive variable names.
    From the data set in previous step , creates a second, independent tidy data set with the average of each variable for each activity and each subject.

A R script (run_analysis.R) has been created to achieve those results.

This codebook describes variables (and data) involved in this project.
Source data

Source data for the project are here.
Zip contains dataset in 4 folder and 28 files - root folder for the project is 'UCI HAR Dataset'
Files used in the project:
- activities_label.txt : defines humain activities coded (1-WALKING, 2- WALKING_UPSTAIRS, 3-WALKING_DOWNSTAIRS, 4-SITTING, 5-STANDING, 6-LAYING)
- features.txt : defines type of measurements taken by sensor signals (accelerometer and gyroscope 3-axial) - 561 different types of measurements including mean, standard deviation, median, max & min value in array. All details are illustrated in "features.info.txt"
- train folder : lists results of people participanting to training (' subject_train.txt' subjects=21 volunteers : with code 1-3-5-6-7-8-11-14-15-16-17-19-21-22-23-25-26-27-28-29-30) + recorded features / activities for training ('X_train.txt'/'Y_train.txt'). Others files in train/Inertial Signals folder are not used in the project
- test folder : with results people participanting to test (' subject_train.txt' subjects= 9 volunteers : with code 2-4-9-10-12-13-18-20-24) + recorded features / activities for test ('X_test.txt'/'Y_test.txt'). Others files in test/Inertial Signals folder are not used in the project
Results

Results of the 'run_analysis.R' script are stored in 'tidyData.txt' (256K file)
It contains the data set with the average of each variable for each activity and each volonteer (180 obs. / 80 variables)
List complete of variables

Volunteer
Activity
TimeBodyAccMeanZ 
TimeBodyAccStdX
TimeBodyAccStdY
TimeBodyAccStdZ
TimeGravityAccMeanX
TimeGravityAccMeanY
TimeGravityAccMeanZ
TimeGravityAccStdX
TimeGravityAccStdY
TimeGravityAccStdZ
TimeBodyAccJerkMeanX
TimeBodyAccJerkMeanY
TimeBodyAccJerkMeanZ
TimeBodyAccJerkStdX
TimeBodyAccJerkStdY
TimeBodyAccJerkStdZ
TimeBodyGyroMeanX
TimeBodyGyroMeanY
TimeBodyGyroMeanZ
TimeBodyGyroStdX
TimeBodyGyroStdY
TimeBodyGyroStdZ
TimeBodyGyroJerkMeanX
TimeBodyGyroJerkMeanY
TimeBodyGyroJerkMeanZ
TimeBodyGyroJerkStdX
TimeBodyGyroJerkStdY
TimeBodyGyroJerkStdZ
TimeBodyAccMagMean
TimeBodyAccMagStd
TimeGravityAccMagMean
TimeGravityAccMagStd
TimeBodyAccJerkMagMean
TimeBodyAccJerkMagStd
TimeBodyGyroMagMean
TimeBodyGyroMagStd
TimeBodyGyroJerkMagMean
TimeBodyGyroJerkMagStd
FrequencyBodyAccMeanX
FrequencyBodyAccMeanY
FrequencyBodyAccMeanZ
FrequencyBodyAccStdX
FrequencyBodyAccStdY
FrequencyBodyAccStdZ
FrequencyBodyAccMeanFreqX
FrequencyBodyAccMeanFreqY
FrequencyBodyAccMeanFreqZ
FrequencyBodyAccJerkMeanX
FrequencyBodyAccJerkMeanY
FrequencyBodyAccJerkMeanZ
FrequencyBodyAccJerkStdX
FrequencyBodyAccJerkStdY
FrequencyBodyAccJerkStdZ
FrequencyBodyAccJerkMeanFreqX
FrequencyBodyAccJerkMeanFreqY
FrequencyBodyAccJerkMeanFreqZ
FrequencyBodyGyroMeanX
FrequencyBodyGyroMeanY
FrequencyBodyGyroMeanZ
FrequencyBodyGyroStdX
FrequencyBodyGyroStdY
FrequencyBodyGyroStdZ
FrequencyBodyGyroMeanFreqX
FrequencyBodyGyroMeanFreqY
FrequencyBodyGyroMeanFreqZ
FrequencyBodyAccMagMean
FrequencyBodyAccMagStd
FrequencyBodyAccMagMeanFreq
FrequencyBodyBodyAccJerkMagMean
FrequencyBodyBodyAccJerkMagStd
FrequencyBodyBodyAccJerkMagMeanFreq
FrequencyBodyBodyGyroMagMean
FrequencyBodyBodyGyroMagStd
FrequencyBodyBodyGyroMagMeanFreq
FrequencyBodyBodyGyroJerkMagMean
FrequencyBodyBodyGyroJerkMagStd
FrequencyBodyBodyGyroJerkMagMeanFreq

    Volunteer(int): identifies each of 30 volunteer involved in the experiment
    Activity (varchar (50) : lists activities associated to measurement . Possible values WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING )
    Rest of variables (num) contains average values of record data merging train and test results.

Following some details of the experiment : features selected for this database come from the accelerometer and gyroscope 3-axial raw signals TimeAccX Y Z and TimeGyroX Y Z. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (TimeBodyAccX Y Z and TimeGravityAccX Y Z) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (TimeBodyAccJerkX Y Z and TimeBodyGyroJerkX Y Z). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (TimeBodyAccMag, TimeGravityAccMag, TimeBodyAccJerkMag, TimeBodyGyroMag, TimeBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing FrequencyBodyAccX Y Z, FrequencyBodyAccJerkX Y Z, FrequencyBodyGyroX Y Z, FrequencyBodyAccJerkMag, FrequencyBodyGyroMag, FrequencyBodyGyroJerkMag. (Note the Frequency indicate frequency domain signals).
These signals were used to estimate variables of the feature vector for each pattern:
'X Y Z' is used to denote 3-axial signals in the X, Y and Z directions.

The set of variables that were estimated from these signals are
Mean: Mean value
Std: Standard deviation

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
gravityMean
TimeBodyAccMean
TimeBodyAccJerkMean
TimeBodyGyroMean
TimeBodyGyroJerkMean
