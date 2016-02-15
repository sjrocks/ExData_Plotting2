library(dplyr)
library(ggplot2)

#clear session
rm(list=ls())

# Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC.motorVehicle <- filter(SCC, grepl("vehicle", EI.Sector, perl = T, ignore.case = T))

NEI.motorVehicle <- inner_join(NEI, SCC.motorVehicle, by="SCC")

# Aggregate By Year
totalByYear <- NEI %>%
  filter(fips=="24510") %>%
  group_by(year) %>%
  summarize(total = sum(Emissions))

# Create Plot
png("plot5.png", width = 640, height = 480)

p <- ggplot(totalByYear, aes(factor(year), total/1000)) + 
  geom_bar(stat = "identity") +
  xlab("Year") +
  ylab("Total PM2.5 Emissions in KTon") +
  ggtitle("Total Emission from motor vehicle in Baltimore")

print(p)

dev.off()