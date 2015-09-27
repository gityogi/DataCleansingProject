# Getting and Cleansing Data Science Project

Project to demonstrate the feature of getting and cleaning data.

## How it works?

There are two function 
 1. loadingFile
 2. run_analysis

First function will be used to download the required data from the following site.
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The second funciton will carry out the main fucntionality.

## Following are the packages which are required to run the script file.

    -library(tools)
    -library(dplyr)
    -library(tidyr)
    -library(reshape)
    -library(reshape2)
    
## How to run run_analysis.r ?
  
  After the going to set directory. Following is command which will run the script file.
  source("run_analysis.R")
  
## Result 
  The result will be a text file which contain the data in the required format.
  The result can be seen in tidy.txt
    