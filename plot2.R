
#Create a class that allows the first colummn of the data file to be read in
#as a date.  This makes it easier to sort by date to get examine the desired
#days.
setClass("myDate")
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

#Set the number of rows in the data file.  Got that number using 'wc' command at command line.
rows=2075259

#Set the classes of the data file column for read in. 
classes<-c("myDate","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")

#Read in the entire data file
alldata<-read.delim("./household_power_consumption.txt",header=TRUE,sep=";", nrows=rows,colClasses=classes,na.strings=c("?"),
                    strip.white=TRUE)

#Pull out the desired days for analysis
data<-alldata[alldata$Date %in% as.Date(c("2007-02-01","2007-02-02")),]

#Create the a POSIXct column.  This makes plotting easier.
data[,2]<-as.POSIXct(strptime(c(paste(data[,1],data[,2],sep=" ")),format="%Y-%m-%d %T",tz="GMT"))

#Plot 2
#Set up the plot device.  Specified width=height to get square proportions.
png("plot2.png", width=480, height=480)

gapyaxis=c("Global Active Power (kilowatts)")

plot(data$Time, data$Global_active_power, type="l",xlab="",ylab=gapyaxis)

#dev off so that the file is complete and display returns to screen.
dev.off()