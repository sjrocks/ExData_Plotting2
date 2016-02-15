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
  filter(fips=="24510" | fips=="06037") %>%
  group_by(fips, year) %>%
  summarize(total = sum(Emissions)) %>%
  mutate(city=ifelse(fips=="24510", "Baltimore", "Los Angeles"))

# Create Plot
png("plot6.png", width = 640, height = 480)

p <- ggplot(totalByYear, aes(x=year, y=total/1000, colour=city)) +
  geom_point(alpha=.3) +
  geom_smooth(alpha=.2, size=1, method="loess") +
  xlab("Year") + ylab("Emission in KTon")
  ggtitle("Vehicle Emissions in Baltimore vs. Los Angeles")

print(p)

dev.off()