library(survival)


source("http://depot.sagebase.org/CRAN.R")
pkgInstall("synapseClient")

require(synapseClient)
synapseLogin()

bio <- synGet("syn1446058")
data.bio <- read.delim(bio$filePath, header = TRUE, stringsAsFactors = FALSE)

data.bio$vital_status[data.bio$vital_status == "LIVING"] <- 0
data.bio$vital_status[data.bio$vital_status == "DECEASED"] <- 1
# coverting the vital status to a binary variable

s <- Surv(data.bio$days_to_last_followup, as.numeric(as.character(data.bio$vital_status))) 
# vital_status is a binary var; 1 = deceased, 0 = living
# days to last follow up = days to death/days to follow up

model <- coxph(s ~ data.bio$ajcc_tumor_stage_code, na.action = na.exclude)
# fits a Cox prop. hazards regression model

summary(model)
cox.zph(model)
# test the assumption for proportionality - need to get appr. straight lines

plot(cox.zph(model))
# plot the result

fit.bygender <- survfit(Surv(days_to_last_followup, vital_status == 1) ~ gender, data = data.bio)
plot(fit.bygender, conf.int = TRUE, col = c("black", "grey"), lty = 1:2, legend.text=c("Female", "Male"))
# comparison of the KM survival curves for men and women