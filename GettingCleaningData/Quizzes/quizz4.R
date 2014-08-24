

# q1: data from https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# Apply strsplit() to split all the names of the data frame on the characters "wgtp". 
# What is the value of the 123 element of the resulting list?
data1 <- read.csv("getdata-data-ss06hid.csv")
head(data1)
splitNames = strsplit(names(data1), "wgtp")
splitNames[[123]]

# q2: data from https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Remove the commas from the GDP numbers in millions of dollars and average them. What is the average? 
data2 <- read.csv("getdata-data-GDP.csv", skip=4, nrows=190)
head(data2)
removeComma <- function(x){gsub(",","",x)}
strVal <- sapply(data2$X.4, FUN=removeComma)
numVal <- as.numeric(strVal)
res <- mean(numVal, na.rm=TRUE)


# q3: same data as q2
# How many countries begin with United?
colnames(data2)[4] <- "countryNames"
grep("^United",data2$countryNames)


# q4: use data from data2 + https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# Match the data based on the country shortcode. 
# Of the countries for which the end of the fiscal year is available, how many end in June? 
data3 <- read.csv("getdata-data-EDSTATS_Country.csv")
head(data3)
june <- grep("*Fiscal year end: June*", data3$Special.Notes)

# q5: 
# Use the following code to download data on Amazon's stock price and get the times the data was sampled
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
# How many values were collected in 2012? How many values were collected on Mondays in 2012?
in2012 <- sampleTimes[grepl("^2012", sampleTimes)]
#(or to get count only: table(grepl("^2012", sampleTimes)))
getDay <- function(d){format(d,"%a")}
days <- sapply(in2012, FUN=getDay)
table(days == "Mon")
