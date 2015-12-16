# 00 Getting & Reading Raw Data

## Downloading Source Data Pack

if (!file.exists("getdata")) {
        dir.create("getdata")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", method = "curl")

## Unziping Source Data Pack

unzip("getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")

## Reading Relevant Data from Pack

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt") 
y_train <- read.table("UCI HAR Dataset/train/y_train.txt") 
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
features <- read.table("UCI HAR Dataset/features.txt")

# 01 Merging the Training and the Test Sets to Create One Data Set

## Adding column names to activity training and test data sets

colnames(y_train) <- c("Activity")
colnames(y_test) <- c("Activity")

## Adding column names to participant (Subject) training and test data sets

colnames(subject_train) <- c("ParticipantNumber")
colnames(subject_test) <- c("ParticipantNumber")

## Adding column names to measurement variables on training and test data sets using labels from the features data set

colnames(x_train) <- features[, 2]
colnames(x_test) <- features[, 2]

## Merging Activity, ParticipantNumber (Subject) and Measurements for training and test data sets

x_train <- cbind(subject_train, x_train)
x_train <- cbind(y_train, x_train)

x_test <- cbind(subject_test, x_test)
x_test <- cbind(y_test, x_test)

## Merging training and test data sets to create one

merged <- rbind(x_train, x_test)
View(merged)

# 02 Extracting Only the Measurements on the Mean and Standard Deviation for Each Measurement

## Naming the columns of the features data set

colnames(features) <- c("Order", "Measurement")
View(features)

## Extracting variables that include the mean and the standard deviation

mean_std_ext <- features$Measurement[grep("mean\\()|std\\()", features$Measurement)]
View(mean_std_ext)

## Creating a subsetting vector 
subsetting_variables <- c("Activity", "ParticipantNumber", as.character(mean_std_ext))

## Subsetting the data set
merged_subset <- merged[, subsetting_variables]

View(merged_subset)

# 03 Using Descriptive Activity Names to Name the Activities in the Data Set

## Replacing the 6 activity code numbers with descriptive names

merged_subset$Activity[merged_subset$Activity == 1] <- c("Walking")
merged_subset$Activity[merged_subset$Activity == 2] <- c("Walking Upstairs")
merged_subset$Activity[merged_subset$Activity == 3] <- c("Walking Downstairs")
merged_subset$Activity[merged_subset$Activity == 4] <- c("Sitting")
merged_subset$Activity[merged_subset$Activity == 5] <- c("Standing")
merged_subset$Activity[merged_subset$Activity == 6] <- c("Laying")

# 04 Appropriately Labelling the Data Set with Descriptive Variable Names

## Replacing abbreviations with full words for the quantitative variables names

names(merged_subset) <- gsub("Acc", "Accelerometer", names(merged_subset))
names(merged_subset) <- gsub("Mag", "Magnitude", names(merged_subset))
names(merged_subset) <- gsub("Gyro", "Gyroscope", names(merged_subset))
names(merged_subset) <- gsub("^t", "time", names(merged_subset))
names(merged_subset) <- gsub("^f", "frequency", names(merged_subset))

# 05 Creating an Independent Tidy Data Set with the Average of Each Variable by Activity and Subject

## Summarizing the data set: Calculating variable averages.  

tidy_data <-aggregate(. ~ Activity + ParticipantNumber, merged_subset, mean)

## Sorting the tidy data set by Activity and ParticipantNumber (Subject)

tidy_data <- tidy_data[order(tidy_data$Activity, tidy_data$ParticipantNumber), ]

## Saving the tidy data set into a text file(r)

write.table(tidy_data, file = "Tidy.txt", row.names = FALSE)

# 06 Reading the Tidy Data Set

tidy <- read.table("Tidy.txt")

View(tidy)

View(merged)

View(merged_subset)

View(tidy_data)

View(features)

View(subsetting_variables)

View(merged_subset)

