# question 4: emissions from coal combustion in the US

# load the ggplot2 library
library(ggplot2)

# load the two data sources into two data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# identify the SCC codes for all EI Sector containing the word "coal"
# and te word "comb"
codes1 <- SCC$SCC[grep("coal", SCC$EI.Sector, ignore.case=TRUE)]
codes2 <- SCC$SCC[grep("comb", SCC$EI.Sector, ignore.case=TRUE)]
codes <- intersect(codes1, codes2)

# filter the NEI data to keep only the records corresponding to those codes
coal <- NEI[NEI$SCC %in% codes,]

# aggregate the data by year
total <- aggregate(coal$Emissions, by=list(coal$year), FUN=sum)
colnames(total) <- c("Year", "Emissions")

# plot the data and print to png file
png("plot4.png")
theplot <- qplot(Year, Emissions, data=total, main="PM2.5 Emissions from Coal Combustion in the US", xlab="Year", ylab="Emissions") + geom_line()
print(theplot)
dev.off()

