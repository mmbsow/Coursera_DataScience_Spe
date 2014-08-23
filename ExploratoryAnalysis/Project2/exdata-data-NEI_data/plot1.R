# question 1: plot the total emissions by year

# load the two data sources into two data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# aggregate the data by year
total <- aggregate(NEI$Emissions, by=list(NEI$year), FUN=sum)
colnames(total) <- c("Year", "Emissions")

# plot the result using the base plotting system
png("plot1.png")
plot(total$Year, total$Emissions, type="o", pch=19, xlab="Year", ylab="Emissions", main="Total PM2.5 Emissions in the US")
dev.off()

# Conclusion:
# The emissions of PM2.5 in the US has drastically decreased from 1999 to 2008
