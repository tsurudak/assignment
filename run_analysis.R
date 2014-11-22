################
# CLASS ASSIGNMENT
# GETTING AND CLEANING DATA
#
# K TSURUDA
# NOV 2014
################

library(plyr)
library(stringr)
library(reshape2)

# set working directory for assignment
setwd("/Users/KT/Documents/Coursera/3cleaning data/assignment")

# download and unzip files from the internet
# # make variable to show where data is
# url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# 
# # download data
# download.file(url, "zippedData.zip", method="curl")
# 
# #unzip downloaded data
# unzip("zippedData.zip")
# 
# #list files in working directory
# list.files()
# 
# #list files in downloaded directory
# list.files("./UCI HAR Dataset")
list.files("./UCI HAR Dataset/train")

# ACTIVITY DATA --------
label.names <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(label.names)  <- c("activityNumber", "activity")
#look at activity data
label.names$activity <- ordered(label.names$activity, 
                          levels = c("WALKING", "WALKING_UPSTAIRS", 
                                     "WALKING_DOWNSTAIRS",
                                     "SITTING", "STANDING", "LAYING"))
label.names$activity <- tolower(label.names$activity)

# FEATURE DATA --------
col.names <- read.table("./UCI HAR Dataset/features.txt", as.is=c(1:2))

# TRAINING DATA --------
#read in training data
train.dat  <- read.table("./UCI HAR Dataset/train/X_train.txt")

#append header names
colnames(train.dat) <- col.names[,2]

#based on the project requirements and features_info.txt, 
# use grepl to select only the features we are interested in
# mean(): Mean value
# std(): Standard deviation
traindat <- train.dat[,grepl("mean\\(\\)|std\\(\\)", names(train.dat))]

#read in subject data
train.subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#make a new variable for this in the data set
traindat$subject  <- train.subject[,1]

#read in activity label data
train.labels  <- read.table("./UCI HAR Dataset/train/y_train.txt")

#make a new variable for this in the data set
traindat$activityNumber  <- train.labels[,1]


# TEST DATA --------
#read in test data
test.dat  <- read.table("./UCI HAR Dataset/test/X_test.txt")

#append header names
colnames(test.dat) <- col.names[,2]

# use grepl to select only the features we are interested in
# mean(): Mean value
# std(): Standard deviation
testdat <- test.dat[,grepl("mean\\(\\)|std\\(\\)", names(test.dat))]

#read in subject data
test.subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#make a new variable for this in the data set
testdat$subject  <- test.subject[,1]

#read in activity label data
test.labels <- read.table("./UCI HAR Dataset/test/y_test.txt")
#make a new variable for this in the data set
testdat$activityNumber  <- test.labels[,1]


# MERGE TRAINING AND TEST DATA --------
dat <- rbind(traindat,testdat)

# USE DESCRIPTIVE ACTIVITY NAMES --------
# merge data to get activity names into the dataframe
dat <- merge(dat, label.names, by = "activityNumber")

# the activityNumber variable is now redundant, remove it
dat <- subset(dat, select=-activityNumber)

# CLEAN UP VARIABLE NAMES --------
# remove parenthenses "()" from variable names
names(dat) <- gsub("\\()","",names(dat))

# replace 't' with 'time' and 'f' with 'frequency' if they are at the start
# of the variable name
names(dat) <- gsub("^f","freq",names(dat))
names(dat) <- gsub("^t","time",names(dat))

# CREATE TIDY DATA SET --------
# creates a second, independent tidy 
# data set with the average of each variable for each activity and 
# each subject


# convert to long format
tidydat <- melt(dat, id.vars = c("subject", "activity"),
                factorsAsStrings=TRUE)

# recast into wide dataset and add in the mean of each measured variable
tidydat2 <- dcast(tidydat, subject + activity ~ variable, fun.aggregate = mean)

#melt again into long data
tidydat <- melt(tidydat2, id.vars = c("subject", "activity"))


# create a new unit variable (time or frequency); determined by pulling
# the first 4 characters off of the variable name
# after the characters are pulled off, they are removed from the original
# variable
tidydat$unit <- str_sub(tidydat$variable, 1, 4)
tidydat$variable <- gsub("^time","",tidydat$variable)
tidydat$variable <- gsub("^freq","",tidydat$variable)

#create a dimension variable using text at the end of the variables
# (X/Y/Z/none) 
# after the new variable is created the -X, -Y, -Z ending is removed
# from the original variable
tidydat$axis <- "NA"
tidydat[grep("-X", tidydat$variable), "axis"]  <- "X"
tidydat[grep("-Y", tidydat$variable), "axis"]  <- "Y"
tidydat[grep("-Z", tidydat$variable), "axis"]  <- "Z"

tidydat$variable <- gsub("-[XYZ]","",tidydat$variable)

#create a measure variable using text in the variables
# (mean/std). After the new variable is created the -mean, -std
# ending is removed from the original variable
tidydat$measure <- NA
tidydat[grep("-mean", tidydat$variable), "measure"]  <- "mean"
tidydat[grep("-std", tidydat$variable), "measure"]  <- "standardDeviation"

tidydat$variable <- gsub("-mean","",tidydat$variable)
tidydat$variable <- gsub("-std","",tidydat$variable)

#create a sensorSignal variable using text in the variables
# (Acc/gyro). After the new variable is created selected text
# ending is removed from the original variable
tidydat$sensor <- NA
tidydat[grep("Acc", tidydat$variable), "sensor"]  <- "accelerometer"
tidydat[grep("Gyro", tidydat$variable), "sensor"]  <- "gyroscope"

tidydat$variable <- gsub("Acc","",tidydat$variable)
tidydat$variable <- gsub("Gyro","",tidydat$variable)

#rename non-descriptive column headings
tidydat <- rename(tidydat, c("variable"="signal", "value"="average"))

#reorder columns to make the tidy data easier to look at
tidydat <- tidydat[c("subject", "activity", "signal", "sensor",
                   "measure", "unit", "axis", "average")]

write.table(tidydat, "tidydata.txt", row.name=FALSE, quote = FALSE,
            sep = ",")

summary(as.factor(tidydat$signal))

save.image()
