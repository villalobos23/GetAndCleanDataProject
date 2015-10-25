#Getting and Cleaning Data
This repo is a course project con Data Science on obtanining and preparing data for
subsequent analysis. Its main purpose is the creation of tidy data set from the 
University of California Irvine Machine Learning Repository, this particular data set
is about "Human Activity Recognition Using Smartphones" more about it on:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Coursera DS JHD Course Project
The related Course is the John Hopkins Getting and Cleaning Data Course from Coursera
##Original Data Set
The measurements presented in the original data set where taken from a group of individuals performing a series of activities with a Samsung Galaxy S. the measurements are taken from the Accelerometers of the smartphone. The data sets form the zipfile are required, they must the unzipped, the data set has two groups (and two folders, train and set), 

##Required Libraries
dplyr version(0.4.3)
stringr version(1.0.0)
data.table version(1.9.6)
R version(3.2.2)
##Steps at work
The operations happen inside run_analysis and they do the following 
* The files are loaded creating 3 files for each group of measurements, 3 for train and 3 for test. The Files used are subject_test, X_test and y_test for the test set and subject_train , X_train and y_train for the train set.
* the columns of the measurements are named after the features given in the original data set then the subject ids and activity labels are added to the data sets, this information is loaded from the features and activity_labels files.
* the final train and test data sets are merged into one
* The mean and standard deviation measurements are extracted. Those regarding frequency of the mean were also excluded to generate an smaller and more concise data set.
* A new data set is created with subject id, activity labels and mean and standard deviation data of the measures of the experiment. 
* This new data set was then grouped by subject and activity using the dplyr package
* The data set was summarized using the grouping described in step 6, missing values were removed and the resulting data was written in the tidySet.txt file.

##Codebook
In this repository we have a codebook (Codebook.md) that describes what the tidy variables are, plus, units of measurement and their origin from the original data set.
##Final Data Set
The final Data set is in the tidySet.txt File
