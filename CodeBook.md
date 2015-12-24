### Raw Data

Raw data can be obtained from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ). Throughout, we will be only working with the following files in the 
downloaded repository:

*	'README.txt' 				: General description of data 
*	'features_info.txt' 		: Genetal description of features
*	'features.txt'				: 561 feature names (character)
*	'activity_labels.txt'		: Integers (1-6) and their corresponding activities (character) 
*	'train/subject_train.txt'	: Integers (1-30) showing their subjects 
*	'train/X_train.txt'			: Normalized numerics between [-1,1] corresponding to features where each line represent one subject and activity
*	'train/y_train.txt'			: Integers (1-6) corresponding to each line of 'X_train.txt'

The same holds for 'test/subject_test.txt', 'test/X_test.txt' and 'test/y_test.txt'.

### Explanation of chosen descriptive variables

The 'features.txt' contains features variables for the data set. Its names do not considered as descriptive, that is why part of the assignment is about choosing/modifying better descriptive variable 
names for mean and standard deviation. The systematic process using regex function `gsub()` in the second task is described as follows:

*	`t` is substituted by `Time`
*	`Acc` is substituted by `Accelerometer`
*	`Gyro` is substituted by `Gyroscope`
*	`Mag` is substituted by `Magnitude` 
*	`f` is substituted by `Frequency`.

The specific description of variables is as follows:

The *Time* domain signal was captured at a constant rate of 50Hz. Acceleration signals were seperated into *body* and *gravity*. Since we have traiaxail linear acceleration (with units, 'Meter per Second square') X,Y,Z and traiaxail angular velocity (units, 'Radian per Second') X,Y,Z then we should specify each variable with either the one captured by *Accelerometer* as in the case of linear acceleration or *Gyroscope* as in the case of angular velocity in addition to specifying the axis (-X,-Y,-Z). The body linear acceleration and angular velocity were derived in time to obtain *Jerk* signals and the *Magnitude* of these three-dimensional signals were calculated using the Euclidean norm. Fast Fourier Transform (FFT) was applied to some of the signals as in the case of *Frequency* domain signals. 

The following functions were applied to data where in this assignment we have only extracted those involving mean and standard deviation.

*	mean(): Mean value
*	std(): Standard deviation
*	mad(): Median absolute deviation 
*	max(): Largest value in array
*	min(): Smallest value in array
*	sma(): Signal magnitude area
*	energy(): Energy measure. Sum of the squares divided by the number of values. 
*	iqr(): Interquartile range 
*	entropy(): Signal entropy
*	arCoeff(): Autorregresion coefficients with Burg order equal to 4
*	correlation(): correlation coefficient between two signals
*	maxInds(): index of the frequency component with largest magnitude
*	meanFreq(): Weighted average of the frequency components to obtain a mean frequency
*	skewness(): skewness of the frequency domain signal 
*	kurtosis(): kurtosis of the frequency domain signal 
*	bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
*	angle(): Angle between to vectors.

**NOTE: We have not extracted those involving Mean**.

### Process of tidying data

1.	Merge the train and test data sets to have a one big united data set using `read.table()` and 		`rbind()`. 
2.	Use regex to extract those columns having exact words `mean()` or `std()` as features. (*Note:* Columns having `meanFreq()` features are not included. If one wants to include them, only change `fixed = T` to `fixed = F`).
3.	Use `merge()` to add descriptive activities to name the activities using relevant labels in 'y_train.txt','y_test', 'subject_train.txt' and 'subject_test.txt'.
4.	Use `gsub()` to add the activity variables found in the second step to the designated columns.
5.	Create an independent data set containing the average of each variable for each activity and each subject using `aggregate()` on the relevant columns.

### Script variables

*	`home`: The working directory containing the raw data
*	`X_train`, `X_test`, `features`, `y_train`, `y_test`, `subject_train`, `subject_test`, and `activity_labels`: Data of their corresponding txt files
*	`combinedData`: Appending two data sets `X_train` and `X_test`.
*	`means`: A numeric vector containing numbers of lines having `mean()`  
*	`stds`: A numeric vector containing numbers of lines having `std()`.
*	`meansVariables`: A vector of characters corresponding to columns  having `mean()` 
*	`stdsVariables`: A vector of characters corresponding to columns having `std()`
*	`extractedMean` and `extractedSds`: Extracting column names having `meansVariables` and `stdsVariables`
*	`extractedMeanStd`: Appending `extractedMean` and `extractedStd`
*	`trainTestLabels`: Appending `y_train` and `y_test`
*	`trainTestSubjects`: Appending `subject_train` and `subject_test`
*	`combinedLabel`: Appending column-wise `trainTestSubjects` and `trainTestLabels`
*	`mergedData`: Merging `activity_labels` and `combinedLabel` for adding corresponding descriptive variables to their columns.
* `substitute`: A function for subtituting and producing desirable descriptive variables using `gsub()`
*	`tidyData`: Aggregating the `mergedData` from columns not having “Activities” and “Subjects” according to “Subjects” and “Activities” columns.
*	 Finally, writing out a `tidyData.csv` using `write.csv()`






 
