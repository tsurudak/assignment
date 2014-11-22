---
title: "README"
author: "K Tsuruda"
date: "November 22, 2014"
output: html_document
---

# README
------
Step 1: The script for this analysis (run_analysis.R) first loads the required libraries.

------
Step 2: an appropriate (local) working directory is set. 

------
Step 3 downloads and unzip files from the internet. This section is commented out because it is assumed for this assignment that the data are available in the local working directly.

------
In Step 4, four different sets of data are read in and manipulated. These are

1. **activity data** : indicates the ID number and name of each activity recoded. This data is essentially a look-up table between the activity number and name and is manipulated so it can be merged with other data later on. Additionally, the activity names are transformed to be lowercase. 

2. **feature data** : indicates the variable names of the features that have been recorded (i.e. the column names for the training and test data, described below)

3. **training data** : measurements of the features (above) for subjects in the training set. We are only interested in features pertaining to the means and standard deviations of the data so the column names (i.e. names of the features) are appended to the data set and only features related to means and starndard deviatoins are kept after the initial file is read in. The subject that has been measured is contained in a different file and this is read in and appended to the updated training feature data. Similarly, the activity label indicating which activity (number) was being measured is contained in a different file. This file is read in and appended to the training feature data containing the subject IDs.

4. **test data** : the test data (and associated files) are in the same format as the training data but contain data pertaining to those subjects who were not in the training data set. The steps taken to read in and manipulate these data are the same as those taken for the training data.

------
In Step 5, the training and test data sets are joined to create one large data set for analysis.

------
In Step 6, the activity names are added to the large data set and the activity numbers are removed from the data set as they are now redundant.

------
In Step 7, some of the variable names are cleaned to facilitate working with them later on. Mainly parentheses in the variable names are deleted and some descriptive text is added.

------
In Step 8, the means of the variables of interest are calculated. First the large data set is melted into the long format. It is then recast into a wide data set using the mean() function to aggregate results, which produces the desired outcome, namely averages of each variable for each activity and each subject. 

------
In Step 9 the tidy data set is created. The wide data set is recast into the long format and the original feature variable names, which each representa number of variables, are deconstructed. New variables are created in the tiny data set so that each column represents only one variable. The columns are renamed and reordered for easy reading.

------
In Step 10 the resulting tidy data set is written to a .txt file using a comma as the separator. The workspace image is saved.
