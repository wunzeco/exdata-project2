## Question 2.
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
## from 1999 to 2008? Use the base plotting system to make a plot answering this question.
library(plyr)

NEI <- readRDS("../summarySCC_PM25.rds")
SCC <- readRDS("../Source_Classification_Code.rds")

bNEI <- subset(NEI, fips == "24510")
## Summarised NEI: Total emissions from 1999 to 2008 in Baltimore City
sNEI <- ddply(bNEI, .(year), summarise, total = sum(Emissions))

## plot graph to png file
#png(filename = "plot2.png", width = 480, height = 480)
with(sNEI, barplot(total, names.arg = year, col = "blue",
                   main = "Baltimore City - Total emissions (1999 to 2008)",
                   xlab = "Year", ylab = "PM2.5 Emissions"))

#dev.off()