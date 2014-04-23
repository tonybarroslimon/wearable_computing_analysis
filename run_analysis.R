enterData <- function(file_name, path_name) {
        file_path <- file.path(path_name, paste("y_", file_name, ".txt", sep = ""))
        yFile <- read.table(file_path, header = FALSE, col.names = c("ActivityID"))
        
        file_path <- file.path(path_name, paste("subject_", file_name, ".txt", sep = ""))
        subject <- read.table(file_path, header = FALSE, col.names = c("SubjectID"))
        
        dataColumns <- read.table("features.txt", header = FALSE, as.is = TRUE, col.names = c("MeasureID", "MeasureName"))
        
        file_path <- file.path(path_name, paste("X_", file_name, ".txt", sept = ""))
        xFile <- read.table(file_path, header = FALSE, col.names = dataColumns$MeasureName)
        
        sub_data_columns <- grep(".*mean\\(\\) |.*std\\(\\)", dataColumns$MeasureName)
        
        data <- xFile[, sub_data_columns]
        
        data$ActivityID <- yFile$ActivityID
        data$SubjectID <- subject$SubjectID
        
        data
}

testData <- function() {
        enterData("test", "test")
}

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

applyActivityLabel <- function(data) {
        activity_labels <- read.table("activity_labels.txt", header=F, as.is=T, col.names=c("ActivityID", "ActivityName"))
        activity_labels$ActivityName <- as.factor(activity_labels$ActivityName)
        data_labeled <- merge(data, activity_labels)
        data_labeled
}

getMergedLabeledData <- function() {
        applyActivityLabel(mergeData())
}

getTidyData <- function(merged_labeled_data) {
        library(reshape2)
        
        id_vars = c("ActivityID", "ActivityName", "SubjectID")
        measure_vars = setdiff(colnames(merged_labeled_data), id_vars)
        melted_data <- melt(merged_labeled_data, id=id_vars, measure.vars=measure_vars)
        
        dcast(melted_data, ActivityName + SubjectID ~ variable, mean)    
}

createTidyDataFile <- function(fname) {
        tidy_data <- getTidyData(getMergedLabeledData())
        write.table(tidy_data, fname)
}

print("Assuming data files from the \"UCI HAR Dataset\" are availale in the current directory with the same structure as in the downloaded archive.")
print("    Refer Data:")
print("    archive: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
print("    description: dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones")
print("Creating tidy dataset as tidy.txt...")
createTidyDataFile("tidy.txt")
print("Done.")