#read in data
Url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(Url, 'week1_project.zip', method = 'curl')
unzip('week1_project.zip') 
powerdata <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";"  )
colnames(powerdata)
summary(powerdata)

TimeStamps <- strptime(paste(powerdata$Date, powerdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
powerdata <- cbind(powerdata, TimeStamps)
head(powerdata)

#adjust data types
powerdata$Date <- as.Date(powerdata$Date, format="%d/%m/%Y")
powerdata$Time <- format(powerdata$Time, format="%H:%M:%S")
powerdata$Global_active_power <- as.numeric(powerdata$Global_active_power)
powerdata$Global_reactive_power <- as.numeric(powerdata$Global_reactive_power)
powerdata$Voltage <- as.numeric(powerdata$Voltage)
powerdata$Global_intensity <- as.numeric(powerdata$Global_intensity)
powerdata$Sub_metering_1 <- as.numeric(powerdata$Sub_metering_1)
powerdata$Sub_metering_2 <- as.numeric(powerdata$Sub_metering_2)
powerdata$Sub_metering_3 <- as.numeric(powerdata$Sub_metering_3)

#subsetting
subsetdata <- subset(powerdata, Date == "2007-02-01" | Date == "2007-02-02")
summary(subsetdata)

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(subsetdata, plot(TimeStamps, Global_active_power, type="l", ylab="Global Active Power"))
with(subsetdata, plot(TimeStamps, Voltage, type = "l", xlab="datetime", ylab="Voltage"))
with(subsetdata, plot(TimeStamps, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
lines(subsetdata$TimeStamps, subsetdata$Sub_metering_2,type="l", col= "red")
lines(subsetdata$TimeStamps, subsetdata$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
with(subsetdata, plot(TimeStamps, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))
dev.off()
