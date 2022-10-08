## This script does the following to the data stored in "./UCI HAR Dataset/" directory:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set.
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Imports
library(dplyr)
library(assertthat)

main <- function() {
    ## Root data directory
    root <- "UCI HAR Dataset"

    ## Get the variable (column) names.
    path <- file.path(root, "features.txt")
    feature_names <- read.table(path)
    feature_names <- feature_names$V2

    ## Get activity labels
    path <- file.path(root, "activity_labels.txt")
    activity_names <- read.table(path)
    activity_names <- activity_names$V2

    ## Function to prepare the test/train data sets. It does the following:
    ## 1. Enriches the data sets with activity names.
    ## 2. Labels the data sets with feature names.
    ## 3. Extracts only the measurements on the mean and standard deviation for each measurement.
    prepare_dataset <- function(name) {
        assert_that(name %in% c("test", "train"))

        subroot <- file.path(root, name)

        # Get the activities
        filename <- paste0("y_", name, ".txt")
        path <- file.path(subroot, filename)
        activities <- read.table(path)
        activity_ids <- activities$V1
        activity_names <- sapply(activity_ids, function(x) activity_names[x])

        # Get the subjects
        filename <- paste0("subject_", name, ".txt")
        path <- file.path(subroot, filename)
        subjects <- read.table(path)
        subject_ids <- subjects$V1

        # Get data
        filename <- paste0("X_", name, ".txt")
        path <- file.path(subroot, filename)
        data <- read.table(path)

        # Label the data set with feature names.
        colnames(data) <- feature_names

        # Enrich the data set with activity names and subject ids.
        data <- cbind(activity = activity_names, subject = subject_ids, data)

        # Extract only the measurements on the mean and standard deviation for each measurement.
        data <- select(data, activity, subject, matches("^.*(mean|std)\\(\\).*$"))

        data
    }

    ## Get the test and the training data sets.
    test_data <- prepare_dataset("test")

    train_data <- prepare_dataset("train")

    ## Merge the two data sets to create the data set required in step#4.
    data <- rbind(test_data, train_data)
    write.csv(data, "data1.csv")

    ## Step 5
    data2 <- aggregate(. ~ subject + activity, data = data, FUN = mean)
    write.csv(data2, "data.csv")

    data2
}

main()