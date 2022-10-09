This repo is meant to contain the code for the programming assignment of the [Getting and Cleaning Data course](https://www.coursera.org/learn/data-cleaning) provided by John Hopkins University as a part of their [Data Science Specialization on Coursera](https://www.coursera.org/specializations/jhu-data-science).

## Objective
To create a couple of tidy data sets out of the data collected from accelerometers from the Samsung Galaxy S smartphone provided by http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

## Workflow
- The raw data provided to us is present in [UCI HAR Dataset](https://github.com/Priyansh121096/DSCourse3Assignment1/tree/main/UCI%20HAR%20Dataset) directory. Details about the raw data set can be read from [UCI HAR Dataset/README.txt](UCI HAR Dataset/README.txt).
- The script [run_analysis.R](run_analysis.R) performs some transformations on the raw data as described in [CodeBook.md](CodeBook.md) and generates two tidy data sets find_data.csv and final_data_aggregated.csv.
- More information on these tidy data sets can be found in [CodeBook.md](CodeBook.md).
