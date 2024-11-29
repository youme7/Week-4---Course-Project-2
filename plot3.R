# EDA wk 4 project 2 (Jishan Hossain)
setwd("~./4 Exploratory Data Analysis/Week 4/Course project 2")
library(dplyr)
library(tidyr)
library(ggplot2)

if (!file.exists("./data")) {
    dir.create("./data")
}
f1 <- file.path(getwd(), "./exdata_data_NEI_data.zip")
unzip(f1, exdir = "./data")
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#3.	Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot 
# answer this question.
Baltimore <- filter(NEI, NEI$fips == "24510")
Baltimore_type <- aggregate(Baltimore$Emissions, list(type = Baltimore$type, year = Baltimore$year), sum)
png("plot3.png", width = 480, height = 480)
qplot(year, x, data = Baltimore_type, color = type, geom = "line") + 
    ggtitle(expression("Total PM"[2.5]*" Emissions in Baltimore by Type")) + 
    xlab("Year") + ylab(expression("PM"[2.5]*" Emissions"))
dev.off()
