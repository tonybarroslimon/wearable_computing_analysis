# Wearable Computing Analysis

## Running the script

* Clone this [repository](https://github.com/tonybarroslimon/wearable_computing_analysis)
* Download this [data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and extract the data. It will create a folder named `UCI HAR Dataset` where all of the files live.
* At the R prompt, change your working directory to the `UCI HAR Dataset` folder.
* Run the `run_analysis.R` script
* The final dataset will be created in the working directory as `wearable_computing_analysis.txt`.

## Things to note

* The training and test data are in folders `train` and `test` within the `UCI HAR Dataset` folder.
* All measurements are located in either the `X_test.txt` or `X_train.txt` files.
* All subject information is located in either the `subject_test.txt` or `subject_train.txt` files.
* All activity codes are located in either the `y_test.txt` or `y_train.txt` files.
* `activity_labels.txt` contain all of the activity codes and the labels.

## How the file works

1. For the training and test datasets,
  1. The file reads the `x` values
  2. Takes the columns subset of the mean and standard deviation values.
  3. Set the columns for activity ID's and subject ID's
  4. Removes the spaces and converts the column names to camel case.
2. Merges the train and test data sets created in step 1.
3. Add an additional column with more descriptive activity names.
4. Melts the dataset with activity ID, name, and subject ID as the only ID variables.
5. Recasts the melted dataset from step 4 above with activity name and subject ID as the only IDs.
6. Finally, it creates the file `wearable_computing_analysis.txt` and saves it in your working directory.
