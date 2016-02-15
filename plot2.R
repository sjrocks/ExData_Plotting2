library(dplyr)

#clear session
rm(list=ls())

# Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Aggregate By Year
totalEmissionByYear <- NEI %>%
  filter(fips=="24510") %>%
  group_by(year) %>%
  summarize(totalEmissions = sum(Emissions))

# Create Plot
png("plot2.png", width = 480, height = 480)

barplot(totalEmissionByYear$totalEmissions/1000, names.arg=totalEmissionByYear$year,
        xlab="Year", ylab = "Emissions (In KTons) ", main="Total PM2.5 emission in Baltimore City")

dev.off()