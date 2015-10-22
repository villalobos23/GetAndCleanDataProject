train.read <- function(activities,featureList){
  subjectTrain <- read.csv(file="./train/subject_train.txt",sep = " ")
  subjectTrain <- rename(subjectTrain,train.subjectID = X1)
  trainingSet <- fread(input ="./train/X_train.txt",sep=" ",header = FALSE)
  trainingSet <- as.data.frame(trainingSet)
  trainingLabels <- read.csv(file="./train/y_train.txt",header = FALSE)
  trainingLabels<- rename(trainingLabels,train.actLabelID = V1)
  trainingSet$train.actLabelID <- trainingLabels$train.actLabelID
  trainingSet$subjectID <- subjectTrain$subjectID
  colnames(trainingSet) <- featureList$feature.description
  trainingSet
}

test.read <- function(activities,featureList){
  subjectTest <- read.csv(file="./test/subject_test.txt",sep = " ")
  subjectTest <- rename(subjectTest,test.subjectID = X2)
  testSet <- fread(input = "./test/X_test.txt",sep=" ",header = FALSE)
  testSet <- as.data.frame(testSet)
  testLabels <- read.csv(file="./test/y_test.txt",header=FALSE)
  testLabels <- rename(testLabels,test.actLabelID = V1)
  testSet$test.actLabelID <- testLabels$test.actLabelID
  testSet$subjectID <- subjectTest$subjectID
  colnames(testSet) <- featureList$feature.description
  testSet
}

analysis.merge <-function(){
  features <- read.csv(file="features.txt",header=FALSE,sep =" ")
  features <- rename(features, feature.ID = V1, feature.description = V2)
  print(length(features$feature.ID))
  activityLabels <- read.csv(file="activity_labels.txt",header = FALSE, sep=" ")
  activityLabels <- rename(activityLabels,activity.ID = V1, activity.descrp = V2)
  #print(activityLabels)
  print(train.read(activityLabels,features))
  #print(test.read(activityLabels,features))
}

analysis.extract <- function(){
  
}

analysis.average <- function(){
  
}

analysis.run <- function(){
  library(dplyr)
  library(data.table)
  analysis.merge()
}
#missing: diferenciar entre las medidas de prueba y las de entrenamiento