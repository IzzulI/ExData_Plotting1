## reading data from text file
data_text <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_text$Date <- as.Date(data_text$Date, format="%d/%m/%Y")


## choose the selected date
data <- subset(data_text, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_text)


## converting the datetime data
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)


## Plot the 4 graph in one image
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),cex=0.5)
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global_reactive_power",xlab="datetime")
})


## Save as image png file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()