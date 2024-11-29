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

#1.	Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.
Total_years <- tapply(NEI$Emissions, INDEX = NEI$year, sum)
png("plot1.png", width = 480, height = 480)
barplot(Total_years, main = expression("Total PM"[2.5]*" Emissions"), xlab = "Year", 
        ylab = expression("PM"[2.5]*" Emissions"), col = "steelblue4")
dev.off()
