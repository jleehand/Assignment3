library(dplyr)
dir = "UCI HAR Dataset"


## Read in all datasets
x_train <- tibble::as_tibble(read.table(paste(dir, "/train/X_train.txt", sep = "")))
x_test <- tibble::as_tibble(read.table(paste(dir, "/test/X_test.txt", sep = "")))

y_train <- tibble::as_tibble(read.table(paste(dir, "/train/Y_train.txt", sep = "")))
y_test <- tibble::as_tibble(read.table(paste(dir, "/test/Y_test.txt", sep = "")))

subject_train <- tibble::as_tibble(read.table(paste(dir, "/train/subject_train.txt", sep = "")))
subject_test <- tibble::as_tibble(read.table(paste(dir, "/test/subject_test.txt", sep = "")))

# Join together the training and test sets. 
measurements <- rbind(x_train, x_test)
activity <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

# Get's the indices of the mean and stddev measurements.
features <- tibble::as_tibble(read.table("UCI HAR Dataset/features.txt"))
mean_std_ind <- grep("mean|std", features$V2)

# Relabelled activities with their qualitative values.
act_labels <- tibble::as_tibble(read.table("UCI HAR Dataset/activity_labels.txt"))
activity <- cut(activity$V1, length(act_labels[,2][[1]]), act_labels[,2][[1]])

# Extract and label only mean and stddev measurements. 
measurements_std_mean <- measurements[, mean_std_ind]
colnames(measurements_std_mean) <- features[mean_std_ind,2][[1]]

# Joined the measurements with the corresponding actvity.
act_measure <- cbind(subject, activity, measurements_std_mean)
colnames(act_measure)[1] <- "subject"

# Save out the merged data to a csv file.
write.csv(act_measure, "activity_measurement.csv")

# Second dataset is generated.
mean_measure_by_sub_act <- group_by(act_measure, subject, activity) %>% summarize_all("mean")
write.csv(mean_measure_by_sub_act, "mean_activity_measurement.csv")
