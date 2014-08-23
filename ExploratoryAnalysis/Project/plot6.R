# question 6: emissions from motor vehicles in Baltimore and Los Angelese

# load the ggplot2 library
library(ggplot2)

# load the two data sources into two data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# get a subset of the data for Baltimore City only
balt <- NEI[NEI$fips == "24510",]
la <- NEI[NEI$fips == "06037",]

# here we define as emissions from motor vehicles any emission 
# from a source that has an EI sector containing the word "mobile"
# and whose type is NOT "NON-ROAD"

# identify the SCC codes for all EI Sectors containing the word "mobile"
mobiles <- SCC$SCC[grep("mobile", SCC$EI.Sector, ignore.case=TRUE)]

# filter the Baltimore and LA NEI data to keep only the records corresponding 
# to the mobile codes and where type is not "NON-ROAD"
balt.motor <- balt[balt$SCC %in% mobiles & balt$type != "NON-ROAD",]
la.motor <- la[la$SCC %in% mobiles & la$type != "NON-ROAD",]

# aggregate the data by year for Baltimore and LA
balt.total <- aggregate(balt.motor$Emissions, by=list(balt.motor$year), FUN=sum)
colnames(balt.total) <- c("Year","Baltimore")
la.total <- aggregate(la.motor$Emissions, by=list(la.motor$year), FUN=sum)
colnames(la.total) <- c("Year","Los.Angeles")

# merge both data frames by year
# with 1 column for Baltimore total and 1 for LA total
totals <- merge(balt.total, la.total)

# plot the data and print to png file
png("plot6.png")
theplot <- ggplot(totals, aes(Year)) + geom_point(aes(y = Baltimore, colour="Baltimore")) + geom_line(aes(y = Baltimore, colour="Baltimore")) + geom_point(aes(y = Los.Angeles, colour="Los.Angeles")) + geom_line(aes(y = Los.Angeles, colour="Los.Angeles")) + xlab("Year") + ylab("Emissions") + ggtitle("PM2.5 Emissions in Baltimore and Los Angeles") + theme(legend.title=element_blank())
print(theplot)
dev.off()