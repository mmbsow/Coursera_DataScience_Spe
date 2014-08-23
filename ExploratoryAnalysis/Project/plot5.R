# question 5: emissions from motor vehicles in Baltimore

# load the ggplot2 library
library(ggplot2)

# load the two data sources into two data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# get a subset of the data for Baltimore City only
balt <- NEI[NEI$fips == "24510",]

# here we define as emissions from motor vehicles any emission 
# from a source that has an EI sector containing the word "mobile"
# and whose type is NOT "NON-ROAD"

# identify the SCC codes for all EI Sectors containing the word "mobile"
mobiles <- SCC$SCC[grep("mobile", SCC$EI.Sector, ignore.case=TRUE)]

# filter the Baltimore NEI data to keep only the records corresponding 
# to the mobile codes and where type is not "NON-ROAD"
motor <- balt[balt$SCC %in% mobiles & balt$type != "NON-ROAD",]

# aggregate the data by year
total <- aggregate(motor$Emissions, by=list(motor$year), FUN=sum)
colnames(total) <- c("Year","Emissions")

# plot the data and print to png file
png("plot5.png")
theplot <- qplot(Year, Emissions, data=total, main="PM2.5 Emissions from Motor Vehicles in Baltimore", xlab="Year", ylab="Emissions") + geom_line()
print(theplot)
dev.off()
