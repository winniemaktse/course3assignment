run_analysis <- function() {
  
  ## Read files
  sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
  X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
  y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
  sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
  X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
  y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
  features <- read.table("UCI HAR Dataset/features.txt")
  
  ## Merges the training and the test sets. (10299 obs.)
  y <- rbind(y_train,y_test)       ## of 1 variable
  X <- rbind(X_train,X_test)       ## of 561 variables
  sub <- rbind(sub_train,sub_test) ## of 1 variables

  ## Extracts only the measurements on the mean and standard deviation for each measurement.
  library(dplyr)
  usefulfeatures <- features[grep(("mean|std"),features$V2),]
  Xdata <- select(X,usefulfeatures$V1)
  
  ## Uses descriptive activity names to name the activities in the data set
  library(plyr)
  y$V2 <- mapvalues(y$V1, from = c(1,2,3,4,5,6),
                          to = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
  
  ## Combine the subject, y and X data into one data set.
  cleandata <- cbind(sub,y$V2,Xdata)
  
  ## Appropriately labels the data set with descriptive variable names.
  usefulfeatures$V2<-gsub("[()]","",usefulfeatures$V2)
  varnames <- c("subject", "activity", as.character(usefulfeatures$V2))
  names(cleandata) <- varnames
  
  ## creates a second and independent tidy data set with the average of each variable 
  ## for each activity and each subject.
  tidydata <- cleandata %>%
    group_by(subject,activity) %>%
    summarise_all(mean)
  
  write.table(tidydata,"tidydata.txt", row.names = FALSE)
  print(tidydata)
}