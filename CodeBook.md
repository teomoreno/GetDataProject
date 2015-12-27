A complement to the script run_analysis.R

Step 00

Download the source data files https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzip the pack into the working directory.

Read project relevant files into the following objects:

subject_train: data frame, 
x_train: data frame, 
y_train: data frame, 
subject_test: data frame, 
x_test: data frame, 
y_test: data frame, 
features: data frame, 

Step 01

Merge training and test data frames to create a new merged object.

merged: data frame, variables, observations

Step 02

Extract observations for the mean and the standard deviation variables to create a new subset object. 

merged_subset: data frame, variables, observations

Step 03

Rename activity numbers with names.

1: Walking
2:  Walking Upstairs
3: Walking Downstairs
4: Sitting
5: Standing
6: Laying

Step 04

Replace abbreviations with full words for the quantitative variables names.

Acc: Accelerometer
Mag: Magnitude
Gyro: Gyroscope
^t: time
^f: frequency

Step 05

Summarize averages for the mean and the standard deviation by activity and participant, subject, into a tidy data set.

tidy_data
data frame, variables, observations

Step 06

Write the tidy object into the Tidy.text file deliverable.
