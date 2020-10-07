#Load data
data <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", colClasses = "character")
n <- nrow(data)
p <- ncol(data)
#Change the class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format = "%H:%M:%S", tz = "")
data[,3:p] <- apply(data[,3:p], 2, as.numeric)
#Filter for Date equal to 2007-02-01 and 2007-02-02
reference <- as.Date(c("2007-02-01", "2007-02-02"))
data_subset <- subset(data, Date %in% reference)
#Create the first plot
hist(data_subset$Global_active_power, col = "red",
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
#Copy the first plot in a png device
dev.copy(png, file = "Plot1.png",  height = 480, width = 480)     
dev.off()
