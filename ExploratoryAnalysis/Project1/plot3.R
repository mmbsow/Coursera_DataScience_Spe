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

# PART 2: generates 3 line plots for Sub metering data by datetime and saves in plot3.png

# x contains the datetime data used in the x-axis of the different graphs
x <- strptime(paste(feb.data$Date, feb.data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

# opens graphic device png file
png(file="plot3.png")

# builds a line-type plot with x and Sub_metering_1
# then add red and blue lines for Sub_metering_2 and Sub_metering_3
plot(x, feb.data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(x, feb.data$Sub_metering_2, col="red")
lines(x, feb.data$Sub_metering_3, col="blue")

# adds legend in top right corner
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black","red","blue"))

# close grahic device
dev.off()