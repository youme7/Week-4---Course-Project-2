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

#5.	How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
Baltimore_onRoad <- subset(NEI, NEI$fips == "24510" & NEI$type == "ON-ROAD")

TTL_Baltimore_onRoad <- aggregate(Baltimore_onRoad[c("Emissions")], 
                                  list(type = Baltimore_onRoad$type, year = Baltimore_onRoad$year, 
                                       zip = Baltimore_onRoad$fips), sum)
png("plot5.png", width = 480, height = 480)
qplot(year, Emissions, data = TTL_Baltimore_onRoad, geom = "line") + theme_gray() + 
    ggtitle("Motor Vehicle-Related Emissions in Baltimore") + xlab("Year") + 
    ylab("Emission Levels")
dev.off()
