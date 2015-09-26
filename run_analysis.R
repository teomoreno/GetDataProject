# 00 Getting & Reading Raw Data

## Downloading Source Data Pack

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", method = "curl")

## Unziping Source Data Pack

unzip("./data/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")

## Reading Relevant Data from Pack

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt") 
y_train <- read.table("UCI HAR Dataset/train/y_train.txt") 
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
features <- read.table("UCI HAR Dataset/features.txt")

# 01 Merging the Training and the Test Sets to Create One Data Set

## Adding Column Names to Activity Training and Test Data Frames

colnames(y_train) <- c("Activity")
colnames(y_test) <- c("Activity")

## Adding Column Names to Participant (Subject) Training and Test Data Frames

colnames(subject_train) <- c("ParticipantNumber")
colnames(subject_test) <- c("ParticipantNumber")

## Adding Column Names to Measurements Training and Test Data Frames

colnames(x_train) <- t(features[2])
colnames(x_test) <- t(features[2])

## Merging Activity, Participant and Measurements Data Frames

x_train <- cbind(subject_train, x_train)
x_train <- cbind(y_train, x_train)

x_test <- cbind(subject_test, x_test)
x_test <- cbind(y_test, x_test)

## Merging Training and Test Sets to Create One

merged <- rbind(x_train, x_test)

# 02 Extracting Only the Measurements on the Mean and Standard Deviation for Each Measurement

## Extracting the Mean Data Measurements

### Extracting column numbers for the mean measurements

mean_ext <- grep("mean()", names(merged), value = FALSE)

### Subsetting the mean measurements using column numbers

measurements_mean <- merged[mean_ext]

## Extracting Standard Deviation Measurements

### Extracting column numbers for standard deviation measurements

std_ext <- grep("std()", names(merged), value = FALSE)

### Subsetting standard deviation measurements using using column numbers

measurements_std <- merged[std_ext]

# 03 Using Descriptive Activity Names to Name the Activities in the Data Set

## Replacing the 6 Activity Code Numbers with Descriptive Names

merged$Activity[merged$Activity == 1] <- c("Walking")
merged$Activity[merged$Activity == 2] <- c("Walking Upstairs")
merged$Activity[merged$Activity == 3] <- c("Walking Downstairs")
merged$Activity[merged$Activity == 4] <- c("Sitting")
merged$Activity[merged$Activity == 5] <- c("Standing")
merged$Activity[merged$Activity == 6] <- c("Laying")

# 04 Appropriately Labelling the Data Set with Descriptive Variable Names

## Replacing Abbreviations with Full Words for the Continuous Variables Names

names(merged) <- gsub("Acc", "Accelerometer", names(merged))
names(merged) <- gsub("Mag", "Magnitude", names(merged))
names(merged) <- gsub("Gyro", "Gyroscope", names(merged))
names(merged) <- gsub("^t", "time", names(merged))
names(merged) <- gsub("^f", "frequency", names(merged))

# 05 Creating an Independent Tidy Data Set with the Average of Each Variable by Activity and Subject

## Summarizing Data Set: Calculating Variable Averages.  

tidy_data <-aggregate(. ~ Activity + ParticipantNumber, merged, mean)

## Sorting the Summary by Activity and ParticipantNumber (Subject)

tidy_data <- tidy_data[order(tidy_data$Activity, tidy_data$ParticipantNumber), ]

## Saving the Tidy Data Set into a Text File

write.table(tidy_data, file = "Tidy.txt", row.names = FALSE)

# 06 Reading the Tidy Data Set

tidy <- read.table("Tidy.txt")

