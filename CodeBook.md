---
title: "CodeBook: Getting and Cleaning Data Assignment"
author: "K Tsuruda"
date: "November 22, 2014"
output: html_document
---

## Study design and background
The following description of the study design and background has been 
quoted from the website hosting the study data and/or the data files (1,2):

> The data for this study comes from a Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain

## Raw data
The original data consisted of a number of files. The following 
description of raw data has been quoted from the README file within the
downloaded data set (2), which was obtained from the Coursera project
webpage (3). 

> #### For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.
>
> #### The dataset includes the following files:
- 'README.txt' 
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
>
> #### The following files are available for the train and test data. Their descriptions are equivalent. 
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second
>
> #### Notes
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.



## Processed (tidy) data
The final processed (tidy data) contains 8 variables, described below:

**subject** : number from 1-30 (inclusive) indicating the subject being measured

**activity** : character variable describing the activity performed ("laying", "sitting",
"standing", "walking", "walking upstairs" or "walking downstairs")

**signal** : character variable indicating the signal being measured. Possible values are:
* Body 
* BodyBodyJerkMag     
* BodyBodyMag        
* BodyJerk
* BodyJerkMag         
* BodyMag         
* Gravity      
* GravityMag

Body refers to body linear acceleration, and Jerk refers to Jerk signals. The magnitude of these three-dimensional signals is indicated by Mag.

**sensor** : character variable indicating the source of the sensor being measured
("accelerometer" and "gyroscope"")

**measure** : a character variable indicating whether the measure is a mean ("mean") or a standard deviation ("standardDeviation") of the original data.

**unit** : a character variable indicating whether the variable unit is time ("time") or a frequency domain ("frequency").

**axis** : character variable indicating the axis the measurement was taken in: "X" "Y", "Z", or "none". "none" is assigned in the case that the measurement has no associated axial direction.

**average** : a numeric variable indicating the value of the average measurement. As the measures are either means or standard deviations, this value is either a mean of a mean or a mean of a standard deviation, depending on the measure variable.

### References
(1) Human Activity Recognition Using Smartphones Data Set. Web. 22 Nov. 2014. <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

(2) Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

(3) Peer Assessments /Getting and Cleaning Data Course Project. Web. 16 Nov. 2014. <https://class.coursera.org/getdata-009/human_grading/view/courses/972587/assessments/3/submissions>