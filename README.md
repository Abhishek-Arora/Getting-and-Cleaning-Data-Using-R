CourseProject
=============


### Introduction

We have data of accelerometer and gyroscope embedded in Samsong Galaxy S II that captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz of 30 volunteers who performed 6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) while wearing the smartphone on their waists. The R script will get and clean the data according to specific steps which is described in CodeBook.md to produce a tidy data set.

### List of included files

*	README.md
*	CodeBook.md
*	run_analysis.R

### General description of raw data

The data set can be obtained from [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. The extensive discussion of raw data can be found in the `README.txt` of the raw data where a summary is as follows.

For each record it is provided:

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

The dataset includes the following files:

* 'README.txt'
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity names.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.

### How to use the script

As indicated in the script `home` is your directly containing the raw data set and you need to change it accordingly. You can run the script using R base or RStudio by including the `source(run_analysis.R)` in the terminal or selecting all and `Ctrl + Enter` in RStudio.

### What the script will do

1.	It merges the train and test data sets to have a one big united data set. 
2.	Using regex, it extracts those columns having exact words `mean()` or `std()` as features. (*Note:* Columns having `meanFreq()` features are not included. If one wants to include them, only change `fixed = T` to `fixed = F`).
3.	It adds descriptive activities to name the activities using relevant labels in 'y_train.txt', 'y_test' and 'features.txt'.
4.	It adds the activity variables found in the second step to the designated columns.
5.	It creates an independent data set `tidyData.csv` containing the average of each variable for each activity and each subject. 





