library(ggplot2)
library(plyr)

d1 <- read.csv("activity.csv")
d2 <- subset(d1, !is.na(steps))
qplot(date,steps,data=d2,geom="histogram",stat="summary", fun.y="sum")

mean1=ddply(d2, .(date), summarize, val=mean(steps)) 
qplot(date,val,data=mean1,geom=c("point"))
median1=ddply(d2, .(date), summarize, val=median(steps)) 
qplot(date,val,data=median1,geom=c("point"))

qplot(x=interval, y=steps, data = d2, geom = "histogram",stat="summary", fun.y="mean")
mean2=ddply(d2, .(interval), summarize, val=mean(steps))

head(arrange(mean2,desc(val)),1)

sum(is.na(d1$steps))   

d3 <- subset(d1, is.na(steps))
mean3=mean(d2[,"steps"])
d3[,"steps"]=mean3
d4=rbind(d3,d2)

qplot(date,steps,data=d4,geom="histogram",stat="summary", fun.y="sum")
mean4=ddply(d4, .(date), summarize, val=mean(steps)) 
qplot(date,val,data=mean4,geom=c("point"))
median4=ddply(d4, .(date), summarize, val=median(steps)) 
qplot(date,val,data=median4,geom=c("point"))

d5=d4
d5$d_type="weekday"
d5[weekdays(as.Date(d5$date)) %in% c("Sunday", "Saturday"),"d_type"]="weekend"
qplot(x=interval, y=steps, data = d5, geom = "histogram",stat="summary", fun.y="mean",facets = . ~ d_type,)



library(knitr)
setwd("RR_PA1")
knit2html("PA1_template.Rmd")
browseURL("PA1_template.html")
