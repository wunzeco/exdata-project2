## Question 6.
## Compare emissions from motor vehicle sources in Baltimore City with emissions 
## from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

library(plyr)
library(ggplot2)

NEI <- readRDS("../summarySCC_PM25.rds")
SCC <- readRDS("../Source_Classification_Code.rds")

## Baltimore and Los Angeles Counties NEI dataset
bl_NEI <- subset(NEI, fips == "24510" | fips == "06037")

# Find moto vehicle sources
vehicleSources <- SCC$SCC[grepl("motor|vehicle|truck", SCC$SCC.Level.Two, ignore.case = TRUE)]
vehicleNEI <- bl_NEI[bl_NEI$SCC %in% vehicleSources,]

## Summarised NEI: Total emissions from motor vehicle sources in Baltimore and 
## Los Angeles Counties (1999 - 2008)
sNEI <- ddply(vehicleNEI, .(year, fips), summarise, total = sum(Emissions))
sNEI$fips <-factor(sNEI$fips, labels = c("Los Angeles", "Baltimore"))

## plot graph to png file
png(filename = "plot6.png", width = 720, height = 480)
qplot(year, total, data = sNEI, facets = . ~ fips, col = fips, geom = c('point','line'),
      xlab = "Year", ylab = "PM2.5 Emissions",
      main = "Total emissions from motor vehicle sources")

dev.off()
