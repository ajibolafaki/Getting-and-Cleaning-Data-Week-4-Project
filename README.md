# Getting-and-Cleaning-Data-Week-4-Project

The following steps were taken to complete week 4 project for Getting and Cleaning Data course on Coursera. The goal of the exercise is to prepare a tidy data set that can be used for later analysis. To this end, an R script -- sun_analysis.R was developed. The script does the following:

- Download data files.
- Import activity and features files.
- Import train and test data set;restrict data to column names that capture mean and standard deviation.
- Import activity and subject data and merge with data set created in previous step
- Append test to train data set
- Convert activity and subject column to factors.
- Create tidy_data.txt -- A summary file that contains the mean value of each variable for each activity and subject pair.


