This code book is meant to describe the data present in [final_data_aggregated.txt](final_data_aggregated.txt). The transformation from the raw data to the tidy data is described in detail in [README.md](README.md). However overall, the tidy data is built by:
1. Combining test and training data from the raw dataset,
2. Performing some selections and enrichements and
3. Aggregating the data by taking the mean of each measurement for each (activity, subject) combination.

# Variables (columns)
## Primary key (grouping)
- `activity (str)` - Name of the activity the subject was performing at the time of the measurements. Can be one of the following: LAYING, SITTING, STANDING, WALKING, WALKING_UPSTAIRS and WALKING_DOWNSTAIRS.
- `subject (int)` - A unique numeric ID assigned to each subject (volunteer) at the time of the experiment. Can be in the range [1, 30].
## Measurements
The measurements in the table include the mean (Mean) and standard deviation (STD) of the following measurements aggregated (by taking average) at the (activity, subject) level:
- tBodyAccXYZ
- tGravityAccXYZ
- tBodyAccJerkXYZ
- tBodyGyroXYZ
- tBodyGyroJerkXYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAccXYZ
- fBodyAccJerkXYZ
- fBodyGyroXYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag

A few notes:
- 'XYZ' is used to denote 3-axial signals in the X, Y and Z directions. So, "colXYZ" means that there'll be three columns in the final dataset corresponding to that measurement viz. "colX", "colY" and "colZ".
- The final dataset contains means and standard deviations of all the measurements in column names like "measurement[Mean|STD]XYZ" (examples, "tBodyAccMeanX", "tBodyGyroSTDZ", etc.)
- All the values of the measurements are `numeric`.
- More information about these measurements can be found at [features_info.txt](https://github.com/Priyansh121096/DSCourse3Assignment1/blob/main/UCI%20HAR%20Dataset/features_info.txt).