# Getting and Cleaning Data - Week 3 Course project
 
"run_analysis.R"" should be located in the directory containing files unzipped from "UCI HAR Dataset.zip" downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## How run_analysis.R works

1. it takes activity lables from "activity_labels.txt"
2. reads IDs of training set activities from "./train/Y_train.txt"
3. merges activity labels and activity ids by columns using labels's ids
4. the same is done for activity labels of test set taken from "./test/Y_test.txt"

5. subjects for train set from "./train/subject_train.txt" is merged with labels from step 3
6. subjects for test set from "./test/subject_test.txt" is merged with labels from step 4

7. 561 feature labels from "features.txt" are obtained to name the columns on further steps

8. training set is read from "./train/X_train.txt" by using scan that returns vector. 
9. It is then trasformed to matrix, using common dimensions of "activity_labels.txt", for example and 561 columns of features.  
10. the column tames are assigned (see step 7) and the matrix is transformed to data.frame
11. the same steps 8 to 10 are repeated with test set from "./test/X_test.txt"

12. training set from step 10 is joined by columns with lables and their ids from step 3
13. the same is done with test set from step 11 and lables + ids from step 4

14. the training and test sets are joined by rows

15. subset the joined training+test dataset to keep only required by assignment columns:
"activity label", "subject", "tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z",
"tBodyAcc-std()-X", "tBodyAcc-std()-Y" and "tBodyAcc-std()-Z"
16. last 6 columns are transformed to numeric

17. the resulted dataset is melted by ids "activity label" and "subject" with measure.vars of the 6 last numeric columns with measurement data. Library "reshape2" was used.

18. then it is casted to a data.frame by `activity label` + subject ~ variable. The mean function is applied to calculate the averages for given activity label and subject (see steps 1,4,5 and6) 

19. the column names of the resulted tidy data was renamed: "mean" was added to the column names to reflect that values were averaged

20. results were saved to "second_tidy_data.txt" with row.names=FALSE as requested

## Codebook describing the "second_tidy_data.txt" variables

"activity label" - the activity levels from the initial "activity_labels.txt" file
can contain values: "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", 
"STANDING", "LAYING"

"subject" - the code representing person participating in tests, can contain values from "1" to "30"

"mean(tBodyAcc-mean()-X)" - numeric value, average of initial "tBodyAcc-mean()-X" values for the given "activity label" and "subject" - see above

"mean(tBodyAcc-mean()-Y)" - same as above for "tBodyAcc-mean()-Y"

"mean(tBodyAcc-mean()-Z)" - same as above for "tBodyAcc-mean()-Z"

"mean(tBodyAcc-std()-X)" - same as above for "tBodyAcc-std()-X"

"mean(tBodyAcc-std()-Y)" - same as above for "tBodyAcc-std()-Y"

"mean(tBodyAcc-std()-Z)" - same as above for "tBodyAcc-std()-Z"
