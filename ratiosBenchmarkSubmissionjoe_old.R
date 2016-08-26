library(data.table)
require(bit64)

Sys.setlocale(category="LC_ALL",locale="chs")
gender_age_test <- fread("gender_age_test.csv",stringsAsFactors=FALSE)
gender_age_train <- fread("gender_age_train.csv",stringsAsFactors=FALSE)
phone_brand_device_model <- fread("phone_brand_device_model.csv",stringsAsFactors=FALSE)
gender_age_train_brand_device<-merge(gender_age_train,phone_brand_device_model,by='device_id',all.x=T)
gender_age_test_brand_device<-merge(gender_age_test,phone_brand_device_model,by='device_id',all.x=T)
categoryFrequencies <- ftable(gender_age_train[,group])/length(gender_age_train[,group])

gender_age_test
  [,"F23-":= categoryFrequencies[1]]
  [,"F24-26":=categoryFrequencies[2]]
  [,"F27-28":=categoryFrequencies[3]]
  [,"F29-32":=categoryFrequencies[4]]
  [,"F33-42":=categoryFrequencies[5]]
  [,"F43+":=categoryFrequencies[6]]
  [,"M22-":=categoryFrequencies[7]]
  [,"M23-26":=categoryFrequencies[8]]
  [,"M27-28":=categoryFrequencies[9]]
  [,"M29-31":=categoryFrequencies[10]]
  [,"M32-38":=categoryFrequencies[11]]
  [,"M39+":=categoryFrequencies[12]]
write.csv(gender_age_test, file.choose(), row.names=FALSE)


head(gender_age_test)