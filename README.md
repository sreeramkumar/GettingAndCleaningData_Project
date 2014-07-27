## GettingAndCleaningData - Course Project
===========================================

This document explains the steps invoved in the run_analysis.R script and any assumptions I made in submitting the project.

Here are the assumptions:

* The code will be run in the main folder containing the data - in the case of the existing zip file, it would be "UCI HAR Dataset" folder.
* The folder structure is maintained, i.e, it'll have sub folders "test" and "train" containing the specific files.
* As per the discussion in the forum for the project, https://class.coursera.org/getdata-005/forum/thread?thread_id=23, I am submitting the tidy data set for the second case, containing averages.

Steps performed in the script:
* Read test data from the three files in "test" sub folder.
* Read train data from the three files in "train" sub folder.
* Read the file "activity_labels.txt". This data is used to give full names to activities in the data set.
* Read the file "features.txt". This data is used to select the required columns from the data set.
* Assign the feature names (second column) from features to the column names for test and train features data. This gives proper names to the columns.
* Find the column names that we are interested in. Out of 561 features, we are only interested in the variables representing means and standard deviations. Looking at the features names, I decided to get the row indices from features.txt, where feature names are matching the pattern "*mean*" or "*std*". However, I have to remove the rows matching "*meanFreq*", as they are incorrectly included in the result. I used to 3 patters as stated above, and found the indices. Then added the indices matching "*mean*" and "*std*" and removed the indices matching "*meanFreq*". This gave me 66 features that I am interested in.
* Subset test features and train features based on the column indices we gotfrom above step.  
* Add the data from subject and activity to the above subset of features for both test and train data.
* Combine test and train data sets using rbind to get the first required data set.
* Provide meaningful column names to activity labels, so we can use it in merge. Make sure that the column name for activity number matches in both the first data set and activity labels.
* Merge the first data set with activity label to expand the activity names
* Get rid of the activity number as we have the names now.
* I have provided more meaningful column names in another file named "colNames.txt". I'll be reading the names from this file to update the column names. This file is updated to the repo. This step completes the requirement for the first tidy data set.
* For the second tidy data set, we use aggregate function and provide the FUN as mean, to get the mean for all variables. We provide Subject and Activity-Label as the id variables, and remove them from the data set, as we don't have to calculate means for them. This step completes the requirement for the second tidy data set.
* Write the second tidy data set into a file to be uploaded for submission.




