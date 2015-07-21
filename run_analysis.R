

# The test and training data from the current directory ./
# are read. The X and Y correspond to the variable data and the activity data. 
Y_train <- read.table("./y_train.txt")
X_train <- read.table("./X_train.txt")
Y_test <- read.table("./y_test.txt")
X_test <- read.table("./X_test.txt")

# The next lines read in the activity label names and the feature names which
# can be used in mapping the integers to the actual label names in the later
# part of the codes. 
label_act <- read.table("./activity_labels.txt")
label_features <- read.table("./features.txt")

# The next lines read subject identities from the test and train data set. 
subject_test <- read.table("./subject_test.txt")
subject_train <- read.table("./subject_train.txt")

# The next two lines column combine the subject identities, activity identities, 
# and the measurement data for the test and training data respectively. 
data_test <- cbind(subject_test, Y_test, X_test)
data_train <- cbind(subject_train, Y_train, X_train)

# The next line row combine the test and training data to form a single data frame.
data_set <- rbind(data_test, data_train)

# The next lines find the indices of the measurement labels associated with the 
# mean and standard deviation. These indices will be used to identify the location
# of the measurements associated with the mean and standard deviation later. 
ind_mean <- grep("[Mm]ean", label_features[,2])
ind_std <- grep("std", label_features[,2])

# Combine the indices of the 1) subject identity, 2) activity identity, and the 
# mean and std measurements into a single index vector ind2. 
ind <- c(ind_mean, ind_std)
ind2 <- c(1,2, ind+2)

# Create a new data frame to include only the subject id, activity id and the mean 
# and std of the measurements. 
data_set_new <- data_set[,ind2]

# Change to more descriptive variable names for each column 
names(data_set_new)[1:2] <- c("Subject", "Activity")
names(data_set_new)[1:length(ind_mean)+2] <- as.character(label_features[ind_mean,2])
names(data_set_new)[((length(ind_mean)+1):(length(ind_mean)+length(ind_std)))+2] <- as.character(label_features[ind_std,2])


# Function to extract activity names
find_activity <- function(act_ind, label_act)
{
    tmp <- label_act[,1] == act_ind
    result <- as.character(label_act[tmp,2])
}


# Convert from activity indices to activity names
data_set_new[,2] <- sapply(data_set_new[,2], find_activity, label_act=label_act)

# Aggregating the results 
tmp <- aggregate(data_set_new[,-c(1,2)], by=data_set_new[,c(2,1)], FUN=mean)

# Write the data frame to a file as specified in the assignment. 
write.table(tmp, "./project_result.txt", row.names = F)





