## Question 4.
## Across the United States, how have emissions from coal combustion-related 
## sources changed from 1999–2008?

library(plyr)
library(ggplot2)

NEI <- readRDS("../summarySCC_PM25.rds")
SCC <- readRDS("../Source_Classification_Code.rds")

# Find Coal combustion-related sources
coalSources <- SCC$SCC[grepl("coal", SCC$Short.Name, ignore.case = TRUE)]
coalNEI <- NEI[NEI$SCC %in% coalSources,]


## Summarised NEI: Total emissions from coal combustion-related sources accros the US (1999 - 2008)
sNEI <- ddply(coalNEI, .(year), summarise, total = sum(Emissions))

## plot graph to png file
png(filename = "plot4.png", width = 480, height = 480)
qplot(year, total, data = sNEI, geom = c('point','line'), 
      xlab = "Year", ylab = "PM2.5 Emissions",
      main = "Total emissions from coal combustion-related sources accros the US")

dev.off()