library(dplyr)
library(ggplot2)

#clear session
rm(list=ls())

# Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Aggregate By Year
totalByTypeAndYear <- NEI %>%
  filter(fips=="24510") %>%
  group_by(type, year) %>%
  summarize(total = sum(Emissions))

# Create Plot
png("plot3.png", width = 640, height = 480)

p <- ggplot(totalByTypeAndYear, aes(x=year, y=total/1000, color=type)) +
      geom_line() +
      xlab("Year") +
      ylab("Total Emission (KTon)") +
      ggtitle("Total Emission by Type in Baltimore City")

print(p)

dev.off()