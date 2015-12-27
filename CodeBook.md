A complement to the script run_analysis.R

Step 00

Download the source data files https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzip the pack into the working directory.

Read project relevant files into the following objects:

subject_train: data frame, 7352 observations for the training data set and one variable with participant number.
x_train: data frame, 7352 observations and 561 quantitative variables for the training data set measurements.
y_train: data frame, 7352 observations for the training data set activity numbers.
subject_test: data frame, 2947 observations for the testing data set and one variable with participant number.
x_test: data frame, 2947 and 561 quantitative variables for the testing data set measurements.
y_test: data frame, 2947 observations for the testing data set activity numbers. 
features: data frame, 561 observations for the quantitative variables names.

Step 01

Merge training and test data frames to create a new merged object.

merged: data frame, 10299 observations and 563 variables including 2 qualitative for activity and participant number and 561 quantitative for measurements.

Step 02

Extract observations for the mean and the standard deviation variables to create a new subset object. 

merged_subset: data frame, 10299 observations and 68 variables including 2 qualitative for activity and participant number and 66 quantitative for mean and standard deviation measurements.

Step 03

Rename activity numbers with names.

Walking for 1. Walking Upstairs for 2. Walking Downstairs for 3. Sitting for 4. Standing for 5. Laying for 6.

Step 04

Replace abbreviations with full words for the quantitative variables names.

Acc with Accelerometer. Mag with Magnitude. Gyro with Gyroscope. ^t with time. ^f with frequency.   

Step 05

Summarize averages for the mean and the standard deviation by activity and participant, subject, into a tidy data set.

tidy_data: data frame, 180 observations and 68 variables including 2 qualitative for activity and participant number and 66 quantitative for mean and standard deviation measurements.

Step 06

Write the tidy object into the Tidy.text file deliverable.

