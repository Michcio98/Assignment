 url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
 download.file(url, destfile = "dataset.zip")
 unzip("dataset.zip")

 x.train <- read.table("UCI HAR Dataset/train/X_train.txt")
 y.train <- read.table("UCI HAR Dataset/train/y_train.txt")
 subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

 x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
 y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
 subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

 x_data <- rbind(x.train, x.test)
 y_data <- rbind(y.train, y_test)
 subject_data <- rbind(subject_train, subject_test)
 
 features <- read.table("UCI HAR Dataset/features.txt")
 mean_std_col <- grep("-(mean|std)\\(\\)", features[, 2])
 
 x_data <- x_data[, mean_std_col]
 names(x_data) <- features[mean_std_col, 2]
 
 activities <- read.table("UCI HAR Dataset/activity_labels.txt")
 y_data[, 1] <- activities[y_data[, 1], 2]
 names(y_data) <- "activity"
 names(subject_data) <- "subject"
 
 final_data <- cbind(subject_data, y_data, x_data)
 tidy_data <- final_data %>%
     group_by(subject, activity) %>%
     summarise_all(list(mean = mean))
 write.table(tidy_data, "tidy_data.txt", row.name = FALSE)