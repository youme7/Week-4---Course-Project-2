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

#2.	Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.
Baltimore <- filter(NEI, NEI$fips == "24510")
Baltimore_sum <- aggregate(Baltimore$Emissions, by = list(year = Baltimore$year), sum)

col1 <- c("firebrick4", "palegreen4", "steelblue4", "gold")
png("plot2.png", width = 480, height = 480)
barplot(Baltimore_sum$x, main = expression("Baltimore City Total PM"[2.5]*" Emissions by Year"), 
        xlab = "Years", ylab = expression("pm"[2.5]*" emissions"), 
        names.arg = Baltimore_sum$year, col = col1)
dev.off()
