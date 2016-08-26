library(data.table)
require(bit64)

Sys.setlocale(category="LC_ALL",locale="chs")
gender_age_test <- fread("gender_age_test.csv",stringsAsFactors=FALSE,colClasses=c('character'))
gender_age_train <- fread("gender_age_train.csv",stringsAsFactors=FALSE,colClasses=c('character','character','character','character'))
phone_brand_device_model <- fread("phone_brand_device_model.csv",stringsAsFactors=FALSE,colClasses=c('character','character','character'))
phone_brand_device_model<-unique(phone_brand_device_model)
gender_age_train_brand_device<-merge(gender_age_train,phone_brand_device_model,by='device_id',all.x=T)
gender_age_train_brand_device<-unique(gender_age_train_brand_device)
gender_age_train_brand_device$makemodel<-paste(gender_age_train_brand_device$phone_brand,gender_age_train_brand_device$device_model)
gender_age_test_brand_device<-merge(gender_age_test,phone_brand_device_model,by='device_id',all.x=T,all.y=F)
gender_age_test_brand_device<-unique(gender_age_test_brand_device)
categoryFrequencies <- ftable(gender_age_train[,group])/length(gender_age_train[,group])

makemodel_group<-as.data.frame(unique(gender_age_train_brand_device$makemodel))
names(makemodel_group)<-c("makemodel")

for (i in 1:nrow(makemodel_group)) {
makemodel_group$"F23-"[i] <- nrow(gender_age_train_brand_device[gender_age_train_brand_device$group=='F23-' & gender_age_train_brand_device$makemodel==makemodel_group$makemodel[i]])
}

for (i in 1:nrow(makemodel_group)) {
  makemodel_group$"F24-26"[i] <- nrow(gender_age_train_brand_device[gender_age_train_brand_device$group=='F24-26' & gender_age_train_brand_device$makemodel==makemodel_group$makemodel[i]])
}

for (i in 1:nrow(makemodel_group)) {
  makemodel_group$"F27-28"[i] <- nrow(gender_age_train_brand_device[gender_age_train_brand_device$group=='F27-28' & gender_age_train_brand_device$makemodel==makemodel_group$makemodel[i]])
}

for (i in 1:nrow(makemodel_group)) {
  makemodel_group$"F29-32"[i] <- nrow(gender_age_train_brand_device[gender_age_train_brand_device$group=='F29-32' & gender_age_train_brand_device$makemodel==makemodel_group$makemodel[i]])
}

for (i in 1:nrow(makemodel_group)) {
  makemodel_group$"F33-42"[i] <- nrow(gender_age_train_brand_device[gender_age_train_brand_device$group=='F33-42' & gender_age_train_brand_device$makemodel==makemodel_group$makemodel[i]])
}

for (i in 1:nrow(makemodel_group)) {
  makemodel_group$"F43+"[i] <- nrow(gender_age_train_brand_device[gender_age_train_brand_device$group=='F43+' & gender_age_train_brand_device$makemodel==makemodel_group$makemodel[i]])
}

for (i in 1:nrow(makemodel_group)) {
  makemodel_group$"M22-"[i] <- nrow(gender_age_train_brand_device[gender_age_train_brand_device$group=='M22-' & gender_age_train_brand_device$makemodel==makemodel_group$makemodel[i]])
}

for (i in 1:nrow(makemodel_group)) {
  makemodel_group$"M23-26"[i] <- nrow(gender_age_train_brand_device[gender_age_train_brand_device$group=='M23-26' & gender_age_train_brand_device$makemodel==makemodel_group$makemodel[i]])
}

for (i in 1:nrow(makemodel_group)) {
  makemodel_group$"M27-28"[i] <- nrow(gender_age_train_brand_device[gender_age_train_brand_device$group=='M27-28' & gender_age_train_brand_device$makemodel==makemodel_group$makemodel[i]])
}

for (i in 1:nrow(makemodel_group)) {
  makemodel_group$"M29-31"[i] <- nrow(gender_age_train_brand_device[gender_age_train_brand_device$group=='M29-31' & gender_age_train_brand_device$makemodel==makemodel_group$makemodel[i]])
}

for (i in 1:nrow(makemodel_group)) {
  makemodel_group$"M32-38"[i] <- nrow(gender_age_train_brand_device[gender_age_train_brand_device$group=='M32-38' & gender_age_train_brand_device$makemodel==makemodel_group$makemodel[i]])
}

for (i in 1:nrow(makemodel_group)) {
  makemodel_group$"M39+"[i] <- nrow(gender_age_train_brand_device[gender_age_train_brand_device$group=='M39+' & gender_age_train_brand_device$makemodel==makemodel_group$makemodel[i]])
}


makemodel_group_probs<- as.data.frame(prop.table(as.matrix(makemodel_group[,2:13]),2))
makemodel_group_probs$makemodel<-makemodel_group$makemodel


makemodel_group_temp<-makemodel_group_probs
makemodel_group_temp[,1]<-categoryFrequencies[1]
makemodel_group_temp[,2]<-categoryFrequencies[2]
makemodel_group_temp[,3]<-categoryFrequencies[3]
makemodel_group_temp[,4]<-categoryFrequencies[4]
makemodel_group_temp[,5]<-categoryFrequencies[5]
makemodel_group_temp[,6]<-categoryFrequencies[6]
makemodel_group_temp[,7]<-categoryFrequencies[7]
makemodel_group_temp[,8]<-categoryFrequencies[8]
makemodel_group_temp[,9]<-categoryFrequencies[9]
makemodel_group_temp[,10]<-categoryFrequencies[10]
makemodel_group_temp[,11]<-categoryFrequencies[11]
makemodel_group_temp[,12]<-categoryFrequencies[12]
makemodel_group_temp$makemodel<-makemodel_group$makemodel


makemodel_group_probs_denom<- makemodel_group_probs[,1:12] * makemodel_group_temp[,1:12]
makemodel_group_probs_denom$makemodel<-makemodel_group$makemodel
makemodel_group_probs_denom$sum<-rowSums(makemodel_group_probs_denom[,1:12])
makemodel_group_probs_denom_temp<-makemodel_group_probs_denom
makemodel_group_probs_denom_temp[,1]<-makemodel_group_probs_denom_temp[,14]
makemodel_group_probs_denom_temp[,2]<-makemodel_group_probs_denom_temp[,14]
makemodel_group_probs_denom_temp[,3]<-makemodel_group_probs_denom_temp[,14]
makemodel_group_probs_denom_temp[,4]<-makemodel_group_probs_denom_temp[,14]
makemodel_group_probs_denom_temp[,5]<-makemodel_group_probs_denom_temp[,14]
makemodel_group_probs_denom_temp[,6]<-makemodel_group_probs_denom_temp[,14]
makemodel_group_probs_denom_temp[,7]<-makemodel_group_probs_denom_temp[,14]
makemodel_group_probs_denom_temp[,8]<-makemodel_group_probs_denom_temp[,14]
makemodel_group_probs_denom_temp[,9]<-makemodel_group_probs_denom_temp[,14]
makemodel_group_probs_denom_temp[,10]<-makemodel_group_probs_denom_temp[,14]
makemodel_group_probs_denom_temp[,11]<-makemodel_group_probs_denom_temp[,14]
makemodel_group_probs_denom_temp[,12]<-makemodel_group_probs_denom_temp[,14]


makemodel_bayesian<-(makemodel_group_probs[,1:12]*makemodel_group_temp[,1:12])/makemodel_group_probs_denom_temp[,1:12]
makemodel_bayesian$makemodel<-makemodel_group$makemodel


gender_age_test_brand_device$makemodel<-paste(gender_age_test_brand_device$phone_brand,gender_age_test_brand_device$device_model)
bayesian_test_data<-merge(as.data.frame(gender_age_test_brand_device),as.data.frame(makemodel_bayesian),by.x='makemodel',by.y='makemodel',all.x=T)
bayesian_test_data_for_submission<-bayesian_test_data[,c(2,5:16)]
write.csv(bayesian_test_data_for_submission, file.choose(), row.names=FALSE)


head(gender_age_test)