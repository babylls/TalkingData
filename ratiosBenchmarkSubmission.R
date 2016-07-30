library(data.table)
require(bit64)

gender_age_test <- fread("gender_age_test.csv")
gender_age_train <- fread("gender_age_train.csv")
categoryFrequencies <- ftable(gender_age_train[,group])/length(gender_age_train[,group])
gender_age_test[,"F23-":= categoryFrequencies[1]][,"F24-26":=categoryFrequencies[2]][,"F27-28":=categoryFrequencies[3]][,"F29-32":=categoryFrequencies[4]][,"F33-42":=categoryFrequencies[5]][,"F43+":=categoryFrequencies[6]][,"M22-":=categoryFrequencies[7]][,"M23-26":=categoryFrequencies[8]][,"M27-28":=categoryFrequencies[9]][,"M29-31":=categoryFrequencies[10]][,"M32-38":=categoryFrequencies[11]][,"M39+":=categoryFrequencies[12]]
write.csv(gender_age_test, file.choose(), row.names=FALSE)