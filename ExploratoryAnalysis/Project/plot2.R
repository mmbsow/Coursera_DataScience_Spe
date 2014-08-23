# question 2: total emissions in Baltimore

# load the two data sources into two data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# get a subset of the data for Baltimore City only
balt <- NEI[NEI$fips == "24510",]

# aggregate the data by year
total <- aggregate(balt$Emissions, by=list(balt$year), FUN=sum)
colnames(total) <- c("Year", "Emissions")

# plot the result using the base plotting system
png("plot2.png")
plot(total$Year, total$Emissions, type="o", pch=19, xlab="Year", ylab="Emissions", main="Total PM2.5 Emissions in Baltimore")
dev.off()

# Conclusion: the emissions has decreased in 2008 after an increase in 2006