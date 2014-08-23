# PART 1: loads the data from file "household_power_consumption.txt"

file.name <- "household_power_consumption.txt"

# first only loads 100 rows to determine the columns classes
initial <- read.table(file.name, na.strings="?", nrows=100, sep=";", header=TRUE)
classes <- sapply(initial, class)

# now reads the full dataset into a data frame and display a few rows to check
data <- read.table(file.name, na.strings="?", sep=";", header=TRUE, colClasses=classes)
head(data)

# subsets just the data for 01-Feb-2007 and 02-Feb-2007
feb.data <- subset(data, Date %in% c("1/2/2007", "2/2/2007"))

# deletes unnecessary variables to free up some memory
remove(initial)
remove(classes)
remove(data)

# PART 2: generates 4 graphs on the same graphic device and saves under plot4.png

# x contains the datetime data used in the x-axis of the different graphs
x <- strptime(paste(feb.data$Date, feb.data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

# opens graphic device png file
png(file="plot4.png")

# splits graphic device in 2 rows / 2 columns
par(mfrow=c(2,2))

# plot 1 in top left corner
plot(x, feb.data$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# plot 2 in top right corner
plot(x, feb.data$Voltage, type="l", xlab="datetime", ylab="Voltage")

# plot 3 in bottom left corner
plot(x, feb.data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(x, feb.data$Sub_metering_2, col="red")
lines(x, feb.data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black","red","blue"))

# plot 4 in bottom right corner
plot(x, feb.data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# closes grahic device
dev.off()