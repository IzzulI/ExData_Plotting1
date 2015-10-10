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


## Plot coloured linechart
with(data, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})

legend("topright",col=c("black","red","blue"),lty=1,lwd=2, 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


## Save as image png file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()