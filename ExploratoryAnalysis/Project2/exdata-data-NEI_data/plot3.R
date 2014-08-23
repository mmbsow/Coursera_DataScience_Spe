# question 3: emissions by source type in Baltimore

# load the ggplot2 library
library(ggplot2)

# load the two data sources into two data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# get a subset of the data for Baltimore City only
balt <- NEI[NEI$fips == "24510",]

# aggregate the data by year and type
bytype <- aggregate(balt$Emissions, by=list(balt$year,balt$type), FUN=sum)
colnames(bytype) <- c("Year", "Type", "Emissions")

# plot the result using the ggplot2 plotting system
# using facets, each type is plotted in its own panel
png("plot3.png")
theplot <- qplot(Year, Emissions, data=bytype, facets=.~Type, main="PM2.5 Emissions By Source Type in Baltimore", xlab="Year", ylab="Emissions") + geom_line()
print(theplot)
dev.off()

# Conclusion:
