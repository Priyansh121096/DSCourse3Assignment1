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

    ## Get activity labels
    path <- file.path(root, "activity_labels.txt")
    activity_names <- read.table(path)
    activity_names <- activity_names$V2

    ## Function to get the test/train data set enriched with subject ids and activity labels.
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

        # Enrich the data set with activity names and subject ids.
        data <- cbind(activity = activity_names, subject = subject_ids, data)

        data
    }

    ## Get the test and the training data sets.
    test_data <- prepare_dataset("test")
    train_data <- prepare_dataset("train")

    ## Merge the two data sets and give human readable column names
    ## to create the data set required in step#4.
    data <- rbind(test_data, train_data)

    # Get the variable (column) names.
    path <- file.path(root, "features.txt")
    feature_names <- read.table(path)
    feature_names <- feature_names$V2
    names(data)[-(1:2)] <- feature_names

    # Extract only the measurements on the mean and standard deviation for each measurement.
    data <- select(data, activity, subject, matches("^.*(mean|std)\\(\\).*$"))

    # Transform feature names into human readable names.
    cleanup_col_name <- function(name) {
        name <- gsub("mean\\(\\)", "Mean", name)
        name <- gsub("std\\(\\)", "STD", name)
        name <- gsub("-", "", name)
    }
    data <- rename_with(data, cleanup_col_name)

    # Write this data to a CSV.
    write.csv(data, "final_data.csv")

    ## Step 5 - create a data set with the average of each variable for each activity and each subject.
    data <- aggregate(. ~ subject + activity, data = data, FUN = mean)
    write.csv(data, "final_data_aggregated.csv")

    data
}

main()
