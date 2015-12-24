## Thorough discussion of data is in README.md and CodeBook.md
## Raw data can be downloaded from 
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## First Task: Merging the training and test data sets.

home = 'workingDirectoryOfDownloadedData'
setwd(home)
setwd('./train')

X_train <- read.table("X_train.txt", sep = "", stringsAsFactors = FALSE)

setwd(home)
setwd('./test')

X_test <- read.table("X_test.txt", sep = "", stringsAsFactors = FALSE)
combinedData <- rbind(X_train, X_test, stringsAsFactors = FALSE)

## Second Task: Extracting the mean and standard deviation measurements
## First, use grep() function (simple regex in R) to identify those lines
## containing mean() and std().

setwd(home)
features <- readLines('features.txt')
# catching mean()
means <- grep(pattern = 'mean()', features, fixed = T)
meansVariables <- sapply(means, function(x) paste("V", x, sep = ""))
extractedMean <- combinedData[,colnames(combinedData) %in% meansVariables]
# catching sd()
stds <- grep(pattern = 'std()', features, fixed = T)
stdsVariables <- sapply(stds, function(x) paste("V", x, sep = ""))
extractedStd <- combinedData[,colnames(combinedData) %in% stdsVariables]
extractedMeanStd <- cbind(extractedMean, extractedStd)

## Third Task: Adding descriptive activity names to name the activities in data set
## adding subject numbers for the later use as well.

setwd('./train')
y_train <- read.table('y_train.txt', sep = '', stringsAsFactors = F)
subject_train <- read.table('subject_train.txt', sep = '', stringsAsFactors = F)

setwd(home)
setwd('./test')
y_test <- read.table('y_test.txt', sep = '', stringsAsFactors = F)
subject_test <- read.table('subject_test.txt', sep = '', stringsAsFactors = F)
trainTestLabels <- rbind(y_train, y_test, stringsAsFactors = F)
trainTestSubjects <- rbind(subject_train, subject_test, stringsAsFactors = F)
combinedLabel <- cbind(trainTestSubjects, trainTestLabels, extractedMeanStd, stringsAsFactors = F)
colnames(combinedLabel)[1:2] <- c("Subjects","ActivityNumbers")

setwd(home)
activity_labels <- read.table('activity_labels.txt', sep = '', stringsAsFactors = F)
colnames(activity_labels) <- c("ActivityNumbers", "Activities")
mergedData <- merge(activity_labels, combinedLabel, by = intersect(names(activity_labels),
                                                                      names(combinedLabel)),
                    all = F)
mergedData["ActivityNumbers"] <- list() #deleting the ActivityNumbers

## Fourth Task: Appropriately labels the data set with descriptive variable names
## using gsub() function and our previouly extracted 'features', 'meansVariables' and 'stdsVariables'.

substitute <- function(line) {
    line <- sub(pattern = 't', 'Time', line)  
    line <- gsub(pattern = 'Acc', 'Accelerometer', line)
    line <- gsub(pattern = 'Gyro', 'Gyroscope', line)
    line <- gsub(pattern = 'Mag', 'Magnitude', line)
    line <- gsub(pattern = 'f', 'Frequency', line)
    line <- gsub(pattern = '[0-9]', '', line)
    line <- gsub(pattern = 'sTimed', 'std', line)
    
}

colnames(mergedData)[3:35] <- lapply(features[means], substitute)
colnames(mergedData)[36:68] <- lapply(features[stds], substitute)

## Fifth Task: Creates a second, independent tidy data set with the average of each 
## variable for each activity and each subject.

tidyData <- aggregate(mergedData[,3:68], by = list(mergedData$Subjects, mergedData$Activities),
                      FUN = mean)
colnames(tidyData)[1:2] <- c("Subjects", "Activities")

setwd(home)
write.csv(tidyData, 'tidyData.csv')














