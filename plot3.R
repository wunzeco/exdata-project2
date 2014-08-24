## Question 3.
## Of the four types of sources indicated by the type (point, nonpoint, onroad, 
## nonroad) variable, which of these four sources have seen decreases in emissions 
## from 1999–2008 for Baltimore City? Which have seen increases in emissions from 
## 1999–2008? 
## Use the ggplot2 plotting system to make a plot to answer this question.

library(plyr)
library(ggplot2)

NEI <- readRDS("../summarySCC_PM25.rds")
SCC <- readRDS("../Source_Classification_Code.rds")

## Baltimore NEI dataset
bNEI <- subset(NEI, fips == "24510")

## Summarised NEI: Total emissions from 1999 to 2008 in Baltimore City
sNEI <- ddply(bNEI, .(year, type), summarise, total = sum(Emissions))

## plot graph to png file
png(filename = "plot3.png", width = 960, height = 480)
qplot(year, total, data = sNEI, geom = c('point','line'), facets = . ~ type, 
      xlab = "Year", ylab = "PM2.5 Emissions",
      main = "Baltimore City - Total emissions (1999 to 2008)")

dev.off()
