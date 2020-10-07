#Load data
data <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", colClasses = "character")
n <- nrow(data)
p <- ncol(data)
#Change the class
data$Time <- paste(data$Date, data$Time)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format = "%d/%m/%Y %H:%M:%S", tz = "")
data[,3:p] <- apply(data[,3:p], 2, as.numeric)
#Filter for Date equal to 2007-02-01 and 2007-02-02
reference <- as.Date(c("2007-02-01", "2007-02-02"))
data_subset <- subset(data, Date %in% reference)
#Create the fourth plot
par(mfcol = c(2,2))
with(data_subset, 
     plot(Time, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))

with(data_subset, {
  plot(Time, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
  lines(Time, Sub_metering_2, type = "l", col = "red")
  lines(Time, Sub_metering_3, type = "l", col = "blue")
  legend("topright",
         lty = 1,
         col = c("black", "red", "blue"),
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), )
}
)

with(data_subset,
  plot(Time, Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
)

with(data_subset,
     plot(Time, Global_reactive_power, type = "l", xlab = "datetime")
)

#Copy the first plot in a png device
dev.copy(png, file = "Plot4.png")  
#Close the device
dev.off()