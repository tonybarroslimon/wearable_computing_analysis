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


