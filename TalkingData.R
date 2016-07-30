library(data.table)
require(bit64)

View(app_event)
app_event <- fread("app_events.csv")
app_labels <- fread("app_labels.csv")
events <- fread("events.csv")
gender_age_test <- fread("gender_age_test.csv")
gender_age_train <- fread("gender_age_train.csv")
label_categories <- fread("label_categories.csv")
phone_brand_device_model <- fread("phone_brand_device_model.csv")
sample_submission <- fread("sample_submission.csv")


