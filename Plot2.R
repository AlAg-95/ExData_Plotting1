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
#Create the second plot
with(data_subset, plot(Time, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
#Copy the first plot in a png device
dev.copy(png, file = "Plot2.png")  
#Close the device
dev.off()
