Data collected from the accelerometer and gyroscope of the Samsung Galaxy S smartphone was  worked withand cleaned, to prepare a tidy data that can be used for later analysis.

This repository contains:
*README.md, this file, which provides an overview of the data set and how it was created.
*tidy.txt, which contains the data set.
*CodeBook.md, the code book, which describes the contents of the data set 
*run_analysis.R, the R script that was used to create the data set 

The file *run_analysis.R* does the following:
*if the dataset does not already exist in the working directory, download it.
*loads the activity and feature info
*loads  the training and the test datasets, keeping only those columns which reflect a mean or standard deviation
*loads the activity and subject data for each dataset, and merges those columns with the dataset
*merges these two datasets
*Converts the activity and subject columns into factors
*Creates  a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.