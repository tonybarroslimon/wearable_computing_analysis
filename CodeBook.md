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