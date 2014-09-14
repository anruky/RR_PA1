Reproducible Research project - PA1
=====================

## Loading and preprocessing the data


```r
d1 <- read.csv("activity.csv")
d2 <- subset(d1, !is.na(steps))
```
## What is mean total number of steps taken per day?

Make a histogram of the total number of steps taken each day

```r
qplot(date,steps,data=d2,geom="histogram",stat="summary", fun.y="sum")
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 

Calculate and report the mean total number of steps taken per day

```r
mean1=ddply(d2, .(date), summarize, val=mean(steps)) 
qplot(date,val,data=mean1,geom=c("point"))
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 

Calculate and report the median total number of steps taken per day

```r
median1=ddply(d2, .(date), summarize, val=median(steps)) 
qplot(date,val,data=median1,geom=c("point"))
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 

## What is the average daily activity pattern?

Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)

```r
qplot(x=interval, y=steps, data = d2, geom = "histogram",stat="summary", fun.y="mean")
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 

```r
mean2=ddply(d2, .(interval), summarize, val=mean(steps))
```

Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?

```r
head(arrange(mean2,desc(val)),1)
```

```
##   interval   val
## 1      835 206.2
```

## Imputing missing values

Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)

```r
sum(is.na(d1$steps))   
```

```
## [1] 2304
```

Create a new dataset that is equal to the original dataset but with the missing data filled in.

```r
d3 <- subset(d1, is.na(steps))
mean3=mean(d2[,"steps"])
d3[,"steps"]=mean3
d4=rbind(d3,d2)
```

Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?

```r
qplot(date,steps,data=d4,geom="histogram",stat="summary", fun.y="sum")
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-91.png) 

```r
mean4=ddply(d4, .(date), summarize, val=mean(steps)) 
qplot(date,val,data=mean4,geom=c("point"))
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-92.png) 

```r
median4=ddply(d4, .(date), summarize, val=median(steps)) 
qplot(date,val,data=median4,geom=c("point"))
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-93.png) 

## Are there differences in activity patterns between weekdays and weekends?

Create a new factor variable in the dataset with two levels ??? ???weekday??? and ???weekend??? indicating whether a given date is a weekday or weekend day.

Make a panel plot containing a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). The plot should look something like the following, which was creating using simulated data:

```r
d5=d4
d5$d_type="weekday"
d5[weekdays(as.Date(d5$date)) %in% c("Sunday", "Saturday"),"d_type"]="weekend"
qplot(x=interval, y=steps, data = d5, geom = "histogram",stat="summary", fun.y="mean",facets = . ~ d_type,)
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10.png) 
