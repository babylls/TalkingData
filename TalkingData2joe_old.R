library(data.table)
require(bit64)








#sample_submission <- fread("sample_submission.csv")

gender_age_train <- fread("gender_age_train.csv")
events <- fread("events.csv")
setkey(events, event_id)
setkey(gender_age_train, device_id)
mergedevents <- merge(events, gender_age_train, all.x=TRUE, by="device_id")
rm(events)
rm(gender_age_train)
gc()

phone_brand_device_model <- fread("phone_brand_device_model.csv")
setkey(phone_brand_device_model, device_id)
# there are duplicate device_ids in phone_brand_device_model. this statement removes duplciates.
# not sure how it resolves conflict
phone_brand_device_model <- unique(phone_brand_device_model)
mergedevents <- merge(mergedevents, phone_brand_device_model, all.x=TRUE, by="device_id")
rm(phone_brand_device_model)
gc()

app_event <- fread("app_events.csv")
setkey(app_event, event_id)
allevents <- merge(app_event, mergedevents, all=TRUE, by="event_id")
rm(mergedevents)
rm(app_event)
gc()

app_labels <- fread("app_labels.csv")
setkey(app_labels, app_id)
# there are duplicate app_ids in app_labels this statement removes duplciates.
# not sure how it resolves conflict
app_labels <- unique(app_labels)
alleventsapps <- merge(allevents, app_labels, all.x=TRUE, by="app_id")
rm(allevents)
gc()

label_categories <- fread("label_categories.csv")
#setkey(alleventsapps, label_id)
setkey(label_categories, label_id)
alleventsappslabels <- merge(alleventsapps, label_categories, all.x=TRUE, by="label_id")
rm(alleventsapps)
gc()

#hist(alleventsappslabels$age)
#gender_age_test <- fread("gender_age_test.csv")

rm(app_event)
rm(app_labels)
rm(events)
rm(gender_age_test)
rm(gender_age_train)
rm(label_categories)
rm(phone_brand_device_model)
rm(sample_submission)

gc()



