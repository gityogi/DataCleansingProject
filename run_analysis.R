 
 
 ## Download and unzip the dataset:
 
 loadingFile <- function(){
                 
                 filename <- "getdata_dataset.zip"
                 
                 if (!file.exists(filename)){
                                 fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
                                 download.file(fileURL, filename)
                 }  
                 if (!file.exists("UCI HAR Dataset")) { 
                                 unzip(filename) 
                 }
                 
                 
 }


run_analysis <- function(){
                
                library(tools)
                library(dplyr)
                library(tidyr)
                library(reshape)
                library(reshape2)
                
                activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
                activityLabels[,2] <- as.character(activityLabels[,2])
                features <- read.table("UCI HAR Dataset/features.txt")
                features[,2] <- as.character(features[,2])
                
                data_X_Test <- rbind(read.table("UCI HAR Dataset/train/X_train.txt", 
                                           colClasses = "numeric"), 
                                read.table("UCI HAR Dataset/test/X_test.txt", 
                                           colClasses = "numeric"))
                
                data_Y_Test <- rbind(read.table("UCI HAR Dataset/train/y_train.txt", 
                                                 colClasses = "numeric"), 
                                      read.table("UCI HAR Dataset/test/y_test.txt", 
                                                 colClasses = "numeric"))
                data_Subject <- rbind(read.table("UCI HAR Dataset/train/subject_train.txt", 
                                               colClasses = "numeric"),
                                    read.table("UCI HAR Dataset/test/subject_test.txt", 
                                               colClasses = "numeric"))

                tempFeatures <- grep(".*mean.*|.*std.*", features[,2])
                data_X_Test <- data_X_Test[, tempFeatures]
                
#                 activityPath <- list.files(recursive = TRUE, pattern="activity_labels.txt")
#                 activities <- read.table(activityPath, col.names=c("activityID", "activityName"), stringsAsFactors=FALSE)
                
                names(data_Subject)[1] <- "subject"
                names(data_Y_Test)[1] <- "activity"
                names(data_X_Test)<-features[tempFeatures, 2]
                myData <- cbind(data_Subject, data_Y_Test, data_X_Test)
                
                myData$activity <- factor(myData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
                myData$subject <- as.factor(myData$subject)
                
                myData.melted <- melt(myData, id = c("subject", "activity"))
                myData.mean <- dcast(myData.melted, subject + activity ~ variable, mean)
                
               write.table( myData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
              
          
}

loadingFile()
run_analysis()