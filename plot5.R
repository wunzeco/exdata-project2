## Question 5.
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library(plyr)
library(ggplot2)

NEI <- readRDS("../summarySCC_PM25.rds")
SCC <- readRDS("../Source_Classification_Code.rds")

## Baltimore NEI dataset
bNEI <- subset(NEI, fips == "24510")

# Find moto vehicle sources
vehicleSources <- SCC$SCC[grepl("motor|vehicle|truck", SCC$SCC.Level.Two, ignore.case = TRUE)]
vehicleNEI <- bNEI[bNEI$SCC %in% vehicleSources,]

## Summarised NEI: Total emissions from motor vehicle sources in Baltimore (1999 - 2008)
sNEI <- ddply(vehicleNEI, .(year), summarise, total = sum(Emissions))

## plot graph to png file
png(filename = "plot5.png", width = 480, height = 480)
qplot(year, total, data = sNEI, xlab = "Year", ylab = "PM2.5 Emissions",
      main = "Total emissions from motor vehicle sources in Baltimore",
      geom = c('point','line'))

dev.off()