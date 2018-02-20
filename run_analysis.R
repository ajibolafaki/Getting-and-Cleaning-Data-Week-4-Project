library(tidyverse)

setwd("C:/Users/Owner/Documents/Coursera/UCI HAR Dataset")

# Import features and activity labels
features <- read.table('./features.txt',header=FALSE)
features[,2] <- as.character(features[,2])

activity_labels <- read.table('./activity_labels.txt',header=FALSE)
activity_labels[,2] <- as.character(activity_labels[,2])

#Extract names pertaining to mean and standard deviation only
#index features with this
#clean up list to use as column names
mean_stdev <- grep(".*mean.*|.*std.*", features[,2])
mean_stdev_names <- features[mean_stdev, 2]
mean_stdev_names <- gsub('-mean','Mean', mean_stdev_names)
mean_stdev_names <- gsub('-std','Stdev', mean_stdev_names)
mean_stdev_names <- gsub('[()-]','', mean_stdev_names)

#Import train data
#Extract only coluns pertaining to mean and standard deviation
#Append all training data
subject_train <- read.table('./train/subject_train.txt',header=FALSE)
x_train <- read.table('./train/X_train.txt',header=FALSE)
x_train_sub <- x_train[mean_stdev]
y_train <- read.table('./train/y_train.txt',header=FALSE)
all_train <- cbind(subject_train, y_train, x_train_sub)


#Import test data
#Extract only coluns pertaining to mean and standard deviation
#Append all test data
subject_test <- read.table('./test/subject_test.txt',header=FALSE)
x_test <- read.table('./test/X_test.txt',header=FALSE)
x_test_sub <- x_test[mean_stdev]
y_test <- read.table('./test/y_test.txt',header=FALSE)
all_test <- cbind(subject_test, y_test, x_test_sub)

#Append test to train, and name columns
train_test <- rbind(all_train,all_test)
names(train_test) <- c("subject", "activity", mean_stdev_names)

#convert subjects and activities to factors
train_test$subject <- as.factor(train_test$subject)
train_test$activity <- factor(train_test$activity, levels = activity_labels[,1], 
                                                   labels = activity_labels[,2])

#calculate mean grouped by activity, and subject
tidy_data <- train_test %>% 
  group_by(activity,subject) %>% 
  summarise_all(mean)

#write out final data frame
write.table(tidy_data, "tidy_data.txt", row.names = FALSE, quote = FALSE)





