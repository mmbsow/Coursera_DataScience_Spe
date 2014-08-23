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

# PART 2: generates histogram for Global Active Power and saves it in plot1.png

# opens graphic device png file
png(file="plot1.png")

# builds an histogram with Global Active Power in the x-axis and Frequency in the y-axis
hist(feb.data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

# close grahic device
dev.off()