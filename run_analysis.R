## The function enterData creates the inital data frame used to merge the data together
## when it is passed the name of the file and the path where that file can be located. 
## This function also subsets the data to pull out only the mean and standard deviation
## measurements.

enterData <- function(file_name, path_name) {
        
        # creates the path to the file with the 'y' name and loads that information as a data table.
        file_path <- file.path(path_name, paste("y_", file_name, ".txt", sep = ""))
        yFile <- read.table(file_path, header = FALSE, col.names = c("ActivityID"))
        
        # creates the path to the subject file and loads that information as a data table.
        file_path <- file.path(path_name, paste("subject_", file_name, ".txt", sep = ""))
        subject <- read.table(file_path, header = FALSE, col.names = c("SubjectID"))
        
        # reads the column names and loads them as a data table.
        dataColumns <- read.table("features.txt", header = FALSE, as.is = TRUE, col.names = c("MeasureID", "MeasureName"))
        
        # creates the path to the file with the 'x' name and loads that information as a data table.
        file_path <- file.path(path_name, paste("X_", file_name, ".txt", sep = ""))
        xFile <- read.table(file_path, header = FALSE, col.names = dataColumns$MeasureName)
        
        # creates the names of the columns required for the data file.
        sub_data_columns <- grep(".*mean\\(\\) |.*std\\(\\)", dataColumns$MeasureName)
        
        # creates the X data file subsetting the data column names done in the previous step.
        data <- xFile[, sub_data_columns]
        
        # appends the subject and activity ID columns.
        data$ActivityID <- yFile$ActivityID
        data$SubjectID <- subject$SubjectID
        
        # returns the data table.
        data
}

# the testData function reads the test data in the test folder and uses the file with the test name.
testData <- function() {
        enterData("test", "test")
}

# the trainData function reads the train data in the train folder and uses the file with the train name.
trainData <- function() {
        enterData("train", "train")
}

mergeData <- function() {
        data <- rbind(testData(), trainData())
        colNames <- colnames(data)
        colNames <- gsub("\\,+mean\\.+", colNames, replacement = "Mean")
        colNames <- gsub("\\,+std\\,+", colNames, replacement = "Std")
        colnames(data) <- colNames
        data
}

addActivityLabel <- function(data) {
        activity_labels <- read.table("activity_labels.txt", header=F, as.is=T, col.names=c("ActivityID", "ActivityName"))
        activity_labels$ActivityName <- as.factor(activity_labels$ActivityName)
        data_labeled <- merge(data, activity_labels)
        data_labeled
}

getMergedLabeledData <- function() {
        addActivityLabel(mergeData())
}

getData <- function(merged_labeled_data) {
        library(reshape2)
        
        id_vars = c("ActivityID", "ActivityName", "SubjectID")
        measure_vars = setdiff(colnames(merged_labeled_data), id_vars)
        melted_data <- melt(merged_labeled_data, id=id_vars, measure.vars=measure_vars)
        
        dcast(melted_data, ActivityName + SubjectID ~ variable, mean)    
}

createDataFile <- function(fname) {
        tidy_data <- getData(getMergedLabeledData())
        write.table(tidy_data, fname)
}

createDataFile("wearable_computing_analysis.txt")