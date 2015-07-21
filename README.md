## Read test and training data

The test and training data from the ./ directory (as specified in the instruction are read. The X and Y correspond to the variable data and the activity data. 

```
Y_train <- read.table("./y_train.txt")
X_train <- read.table("./X_train.txt")
Y_test <- read.table("./y_test.txt")
X_test <- read.table("./X_test.txt")
```

## Read activity and feature names
The next lines read in the activity label names and the feature names which can be used in mapping the integers to the actual label names in the later part of the codes. 
```
label_act <- read.table("./activity_labels.txt")
label_features <- read.table("./features.txt")
```

## Read subject IDs from files
The next lines read subject identities from the test and train data set. 
```
subject_test <- read.table("./subject_test.txt")
subject_train <- read.table("./subject_train.txt")
```

## Combine IDs and measurements 
The next two lines column combine the subject identities, activity identities, and the measurement data for the test and training data respectively. 
```
data_test <- cbind(subject_test, Y_test, X_test)
data_train <- cbind(subject_train, Y_train, X_train)
```

## Combine test and training data
The next line row combine the test and training data to form a single data frame.
```
data_set <- rbind(data_test, data_train)
```

## Find indices for mean and std measurements
The next lines find the indices of the measurement labels associated with the mean and standard deviation. These indices will be used to identify the location of the measurements associated with the mean and standard deviation later. 
```
ind_mean <- grep("[Mm]ean", label_features[,2])
ind_std <- grep("std", label_features[,2])
```

## Combine indices
Combine the indices of the 1) subject identity, 2) activity identity, and the mean and std measurements into a single index vector ind2. 
```
ind <- c(ind_mean, ind_std)
ind2 <- c(1,2, ind+2)
```

## Create a new data frame
Create a new data frame to include only the subject id, activity id and the mean and std of the measurements. 
```
data_set_new <- data_set[,ind2]
```

## More descriptive variable names
Change to more descriptive variable names for each column 
```
names(data_set_new)[1:2] <- c("Subject", "Activity")
names(data_set_new)[1:length(ind_mean)+2] <- as.character(label_features[ind_mean,2])
names(data_set_new)[((length(ind_mean)+1):(length(ind_mean)+length(ind_std)))+2] <- as.character(label_features[ind_std,2])
```

## Function to extract activity names
```
find_activity <- function(act_ind, label_act)
{
    tmp <- label_act[,1] == act_ind
    result <- as.character(label_act[tmp,2])
}
```

## Convert from activity indices to activity names
```
data_set_new[,2] <- sapply(data_set_new[,2], find_activity, label_act=label_act)
```
## Aggregating the results 
```
tmp <- aggregate(data_set_new[,-c(1,2)], by=data_set_new[,c(2,1)], FUN=mean)
```
## Write the data frame to a file as specified in the assignment. 
```
write.table(tmp, "./project_result.txt", row.names = F)
```


## The code book describing each variable
The following list describes the names of the variables presented in the final data set. The index i enclosed by [i] describes the column of the data set. For example, in the first column, the variable name is the Subject ID. The second column corresponds to the activity label. The labels used for the mean and SD of the measurements are based on a subset of variables associated only the mean and std of those described in the file features.txt as features_info.txt. The acceleration is in the unity of gravity 'g'. 

 [1] "Subject"                  
 [2] "Activity"                            
 [3] "tBodyAcc-mean()-X"                   
 [4] "tBodyAcc-mean()-Y"                   
 [5] "tBodyAcc-mean()-Z"                   
 [6] "tGravityAcc-mean()-X"                
 [7] "tGravityAcc-mean()-Y"                
 [8] "tGravityAcc-mean()-Z"                
 [9] "tBodyAccJerk-mean()-X"               
[10] "tBodyAccJerk-mean()-Y"               
[11] "tBodyAccJerk-mean()-Z"               
[12] "tBodyGyro-mean()-X"                  
[13] "tBodyGyro-mean()-Y"                  
[14] "tBodyGyro-mean()-Z"                  
[15] "tBodyGyroJerk-mean()-X"              
[16] "tBodyGyroJerk-mean()-Y"              
[17] "tBodyGyroJerk-mean()-Z"              
[18] "tBodyAccMag-mean()"                  
[19] "tGravityAccMag-mean()"               
[20] "tBodyAccJerkMag-mean()"              
[21] "tBodyGyroMag-mean()"                 
[22] "tBodyGyroJerkMag-mean()"             
[23] "fBodyAcc-mean()-X"                   
[24] "fBodyAcc-mean()-Y"                   
[25] "fBodyAcc-mean()-Z"                   
[26] "fBodyAcc-meanFreq()-X"               
[27] "fBodyAcc-meanFreq()-Y"               
[28] "fBodyAcc-meanFreq()-Z"               
[29] "fBodyAccJerk-mean()-X"               
[30] "fBodyAccJerk-mean()-Y"               
[31] "fBodyAccJerk-mean()-Z"               
[32] "fBodyAccJerk-meanFreq()-X"           
[33] "fBodyAccJerk-meanFreq()-Y"           
[34] "fBodyAccJerk-meanFreq()-Z"           
[35] "fBodyGyro-mean()-X"                  
[36] "fBodyGyro-mean()-Y"                  
[37] "fBodyGyro-mean()-Z"                  
[38] "fBodyGyro-meanFreq()-X"              
[39] "fBodyGyro-meanFreq()-Y"              
[40] "fBodyGyro-meanFreq()-Z"              
[41] "fBodyAccMag-mean()"                  
[42] "fBodyAccMag-meanFreq()"              
[43] "fBodyBodyAccJerkMag-mean()"          
[44] "fBodyBodyAccJerkMag-meanFreq()"      
[45] "fBodyBodyGyroMag-mean()"             
[46] "fBodyBodyGyroMag-meanFreq()"         
[47] "fBodyBodyGyroJerkMag-mean()"         
[48] "fBodyBodyGyroJerkMag-meanFreq()"     
[49] "angle(tBodyAccMean,gravity)"         
[50] "angle(tBodyAccJerkMean),gravityMean)"
[51] "angle(tBodyGyroMean,gravityMean)"    
[52] "angle(tBodyGyroJerkMean,gravityMean)"
[53] "angle(X,gravityMean)"                
[54] "angle(Y,gravityMean)"                
[55] "angle(Z,gravityMean)"                
[56] "tBodyAcc-std()-X"                    
[57] "tBodyAcc-std()-Y"                    
[58] "tBodyAcc-std()-Z"                    
[59] "tGravityAcc-std()-X"                 
[60] "tGravityAcc-std()-Y"                 
[61] "tGravityAcc-std()-Z"                 
[62] "tBodyAccJerk-std()-X"                
[63] "tBodyAccJerk-std()-Y"                
[64] "tBodyAccJerk-std()-Z"                
[65] "tBodyGyro-std()-X"                   
[66] "tBodyGyro-std()-Y"                   
[67] "tBodyGyro-std()-Z"                   
[68] "tBodyGyroJerk-std()-X"               
[69] "tBodyGyroJerk-std()-Y"               
[70] "tBodyGyroJerk-std()-Z"               
[71] "tBodyAccMag-std()"                   
[72] "tGravityAccMag-std()"                
[73] "tBodyAccJerkMag-std()"               
[74] "tBodyGyroMag-std()"                  
[75] "tBodyGyroJerkMag-std()"              
[76] "fBodyAcc-std()-X"                    
[77] "fBodyAcc-std()-Y"                    
[78] "fBodyAcc-std()-Z"                    
[79] "fBodyAccJerk-std()-X"                
[80] "fBodyAccJerk-std()-Y"                
[81] "fBodyAccJerk-std()-Z"                
[82] "fBodyGyro-std()-X"                   
[83] "fBodyGyro-std()-Y"                   
[84] "fBodyGyro-std()-Z"                   
[85] "fBodyAccMag-std()"                   
[86] "fBodyBodyAccJerkMag-std()"           
[87] "fBodyBodyGyroMag-std()"              
[88] "fBodyBodyGyroJerkMag-std()"  

