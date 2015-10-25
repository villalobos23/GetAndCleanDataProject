train.read <- function(activities,featureList){
  subjectTrain <- read.csv(file="./train/subject_train.txt",sep = " ",header = FALSE)
  subjectTrain <- rename(subjectTrain,subjectID = V1)
  trainingSet <- fread(input ="./train/X_train.txt",sep=" ",header = FALSE)
  trainingSet <- as.data.frame(trainingSet)
  colnames(trainingSet) <- featureList$feature.description
  trainingLabels <- read.csv(file="./train/y_train.txt",header = FALSE)
  trainingLabels<- rename(trainingLabels,actLabelID = V1)
  trainingSet$actLabelID <- trainingLabels$actLabelID
  trainingSet$subjectID <- subjectTrain$subjectID
  trainingSet <- merge(trainingSet,activities,by.x = "actLabelID", by.y = "activity.ID" )
  trainingSet
}

test.read <- function(activities,featureList){
  subjectTest <- read.csv(file="./test/subject_test.txt",sep = " ",header = FALSE)
  subjectTest <- rename(subjectTest,subjectID = V1)
  testSet <- fread(input = "./test/X_test.txt",sep=" ",header = FALSE)
  testSet <- as.data.frame(testSet)
  colnames(testSet) <- featureList$feature.description
  testLabels <- read.csv(file="./test/y_test.txt",header=FALSE)
  testLabels <- rename(testLabels,actLabelID = V1)
  testSet$actLabelID <- testLabels$actLabelID
  testSet$subjectID <- subjectTest$subjectID
  testSet <- merge(testSet,activities,by.x="actLabelID",by.y="activity.ID")
  testSet
}
#improve to do all replacements at once
analysis.prepareFeatures <- function(featureList){
  featureNames <- featureList$feature.description
  featureNames <- str_replace_all(featureNames,"[\\(\\)]","")
  featureNames <- str_replace_all(featureNames,"[-]","")
  featureNames <- str_replace_all(featureNames,"Acc","acceleration")
  featureNames <- str_replace_all(featureNames,"std","standarddeviation")
  featureNames <- str_replace_all(featureNames,"Gyro","gyroscope")
  featureNames <- str_replace_all(featureNames,"Mag","magnitude")
  featureNames <- str_replace_all(featureNames,"Energy","energy")
  featureNames <- str_replace_all(featureNames,"Body","body")
  featureNames <- str_replace_all(featureNames,"Jerk","jerk")
  featureNames <- str_replace_all(featureNames,"Gravity","gravity")
  featureNames <- str_replace_all(featureNames,"X","inx")
  featureNames <- str_replace_all(featureNames,"Y","iny")
  featureNames <- str_replace_all(featureNames,"Z","inz")
  featureNames <- gsub("^t","timefor",featureNames)
  featureNames <- gsub("^f","frequencyfor",featureNames)
  featureNames
}

analysis.merge <-function(){
  merged.dataset <- data.frame()
  features <- read.csv(file="features.txt",header=FALSE,sep =" ")
  features <- rename(features, feature.ID = V1, feature.description = V2)
  features$feature.description <- analysis.prepareFeatures(features)
  activityLabels <- read.csv(file="activity_labels.txt",header = FALSE, sep=" ")
  activityLabels <- rename(activityLabels,activity.ID = V1, activity.descrp = V2)
  trainDS <- train.read(activityLabels,features)
  testDS <- test.read(activityLabels,features)
  merged.dataset <- rbind(trainDS,testDS)
}

analysis.extract <- function(){
  merged <- analysis.merge()
  columnNames <- colnames(merged)
  meanCols <- merged[,grep('mean',columnNames)]
  meanCols <- select(meanCols,-contains("meanFreq"))
  stdCols <- merged[grep('standarddeviation',columnNames)]
  extracted <- data.frame(subjectID = merged$subjectID)
  extracted$activity <- merged$activity.descrp
  extracted <- cbind(extracted,meanCols)
  extracted <- cbind(extracted,stdCols)
}

analysis.average <- function(){
  bulk <- analysis.extract()
  subjectsAverage <- group_by(bulk,subjectID,activity)
  summarize_each(subjectsAverage,funs(mean(.,na.rm = TRUE)))
}

analysis.run <- function(){
  library(dplyr)
  library(data.table)
  library(stringr)
  tidySet <- analysis.average()
  write.table(tidySet,file="tidySet.txt",row.names = FALSE)
  tidySet
}
#renombrar las variables mejor