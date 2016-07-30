library(data.table)
require(bit64)

app_event <- fread("app_events.csv")
app_labels <- fread("app_labels.csv")
events <- fread("events.csv")
gender_age_test <- fread("gender_age_test.csv")
gender_age_train <- fread("gender_age_train.csv")
label_categories <- fread("label_categories.csv")
phone_brand_device_model <- fread("phone_brand_device_model.csv")
sample_submission <- fread("sample_submission.csv")


setkey(events, event_id)
setkey(gender_age_train, device_id)
mergedevents <- merge(events, gender_age_train, all.x=TRUE, by="device_id")

setkey(phone_brand_device_model, device_id)
# there are duplicate device_ids in phone_brand_device_model. this statement removes duplciates.
# not sure how it resolves conflict
phone_brand_device_model <- unique(phone_brand_device_model)
mergedevents <- merge(mergedevents, phone_brand_device_model, all.x=TRUE, by="device_id")

setkey(app_event, event_id)
allevents <- merge(app_event, mergedevents, all=TRUE, by="event_id")
rm(mergedevents)

setkey(app_labels, app_id)
# there are duplicate app_ids in app_labels this statement removes duplciates.
# not sure how it resolves conflict
app_labels <- unique(app_labels)
alleventsapps <- merge(allevents, app_labels, all.x=TRUE, by="app_id")
rm(allevents)

#setkey(alleventsapps, label_id)
setkey(label_categories, label_id)
alleventsappslabels <- merge(alleventsapps, label_categories, all.x=TRUE, by="label_id")
rm(alleventsapps)

#hist(alleventsappslabels$age)


