"/Users/Mariame/Repositories/Coursera_DataScience_Spe/ExploratoryAnalysis/Project"
# read in the 2 data sources
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

# question 1:
# aggregate the data by year
# plot the result using the base plotting system
total <- aggregate(NEI$Emissions, by=list(NEI$year), FUN=sum)
png("plot1.png")
plot(total$Group.1, total$x, type="o", pch=19, xlab="Year", ylab="Emissions", main="Total Emissions from PM2.5 in the US")
dev.off()

# question 2:
# get a subset of the data for Baltimore City only
# aggregate the data by year
# plot the result using the base plotting system
balt <- NEI[NEI$fips == "24510",]
b.total <- aggregate(balt$Emissions, by=list(balt$year), FUN=sum)
png("plot2.png")
plot(b.total$Group.1, b.total$x, type="o", pch=19, xlab="Year", ylab="Emissions", main="Total Emissions from PM2.5 in Baltimore")
dev.off()

# question 3:
# aggregate the data by year and type
# plot the result using the ggplot2 plotting system
# using facets, each type is plotted in its own panel
library(ggplot2)
b.types <- aggregate(balt$Emissions, by=list(balt$year,balt$type), FUN=sum)
png("plot3.png")
qplot(Group.1, x, data=b.types, facets=.~Group.2, main="Emissions from PM2.5 By Type in Baltimore City", xlab="Year", ylab="Emissions") + geom_line()
dev.off()

# question 4:
# identify the SCC codes for all EI Sector containing the word "coal" and "comb"
# filter the NEI data to keep only the records corresponding to those codes
# aggregate the data by year
# plot the data
temp <- SCC[grep("coal", SCC$EI.Sector, ignore.case=TRUE),]
coal.codes <- temp$SCC[grep("comb", temp$EI.Sector, ignore.case=TRUE)]
coal <- NEI[NEI$SCC %in% coal.codes,]
coal.total <- aggregate(coal$Emissions, by=list(coal$year), FUN=sum)
png("plot4.png")
qplot(Group.1, x, data=coal.total, main="Emssions from PM2.5 from Coal Combustion in the US", xlab="Year", ylab="Emissions") + geom_line()
dev.off()

# question 5
# identify the SCC codes for all EI Sectors containing the word "mobile"
# filter the Baltimore NEI data to keep only the records corresponding to those codes and
# where type is not "NON-ROAD"
# aggregate the data by year
# plot the data
#4 Mobile sources
#Mobile sources overview
#Mobile sources are sources of pollution caused by vehicles transporting goods or people (e.g., highway vehicles,                                                                                      aircraft, rail, and marine vessels) and other nonroad engines and equipment, such as lawn and garden equipment, construction equipment, engines used in recreational activities, and portable industrial, commercial, and agricultural engines. 
# En se basant sur cette definition, sont consideres motor vehicles all mobiles that are not onroad
mobiles <- SCC$SCC[grep("mobile", SCC$EI.Sector, ignore.case=TRUE)]
balt.motor <- balt[balt$SCC %in% mobiles & balt$type != "NON-ROAD",]
balt.motor.agg <- aggregate(balt.motor$Emissions, by=list(balt.motor$year), FUN=sum)
colnames(balt.motor.agg) <- c("Year","Baltimore")
png("plot5.png")
qplot(Year, Baltimore, data=balt.motor.agg, main="Emissions from PM2.5 from Motor Vehicles in Baltimore", xlab="Year", ylab="Emissions") + geom_line()
dev.off()

# question 6
# get a subset of the data for Los Angeles only
# filter the Los Angeles NEI data to keep only the records corresponding to those codes and
# where type is not "NON-ROAD"
# Rename the columns in Baltimore and Los Angeles Motor Vehical data frames
# Merge the Motor Vehicles data for Baltimore and Los Angeles so that each city represents one column
# aggregate the data by year
# plot the data with each city representing one line
la <- NEI[NEI$fips == "06037",]
la.motor <- la[la$SCC %in% mobiles & la$type != "NON-ROAD",]
la.motor.agg <- aggregate(la.motor$Emissions, by=list(la.motor$year), FUN=sum)
colnames(la.motor.agg) <- c("Year","Los.Angeles")
cities <- merge(balt.motor.agg, la.motor.agg)
png("plot6.png")
ggplot(cities, aes(Year)) + geom_line(aes(y = Baltimore, ylab="Emissions", colour="Baltimore")) + geom_line(aes(y = Los.Angeles, colour="Los.Angeles")) + geom_point(aes(y = Baltimore, colour="Baltimore")) + geom_point(aes(y = Los.Angeles, colour="Los.Angeles")) + xlab("Year") + ylab("Emissions") + ggtitle("Emissions from PM2.5 in Baltimore and Los Angeles") + theme(legend.title=element_blank())
dev.off()

