
setClass("myDate")
#setClass("myTime")
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

rows=2075259

classes<-c("myDate","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")

alldata<-read.delim("../household_power_consumption.txt",header=TRUE,sep=";", nrows=rows,colClasses=classes,na.strings=c("?"),
                     strip.white=TRUE)

data<-alldata[alldata$Date %in% as.Date(c("2007-02-01","2007-02-02")),]

#sat<-alldata[alldata$Time %in% c("00:00:00") & alldata$Date %in% as.Date(c("2007-02-03")),]

data[,2]<-as.POSIXct(strptime(c(paste(data[,1],data[,2],sep=" ")),format="%Y-%m-%d %T",tz="GMT"))

dow<-sapply(data$weekday,weekdays)

data<-cbind(dow,data)

data$dow<-as.factor(data$dow)

plot1<-hist(data$Global_active_power, col="red", ylim=c(0,1200),main=c("Global Active Power"), xlab=c("Global Active Power (kilowatts)"))


