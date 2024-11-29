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

#4.	Across the United States, how have emissions from coal combustion-related sources changed 
# from 1999-2008?
greps1 <- unique(grep("coal", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))  
#Isolate instances of "coal" in SCC

SCC_coal <- subset(SCC, EI.Sector %in% greps1)    #Subset SCC by coal labels
NEI_coal <- subset(NEI, SCC %in% SCC_coal$SCC)    #Subset NEI by SCC_coal overlaps
emissions_coal <- summarise(group_by(NEI_coal, year), Emissions = sum(Emissions))
png("plot4.png", width = 480, height = 480)
ggplot(emissions_coal, aes(x = factor(year), y = Emissions/1000, fill = year, 
                           label = round(Emissions/1000,2))) +
    geom_bar(stat = "identity") +
    xlab("year") +
    ylab(expression("total PM"[2.5]*" emissions in kilotons")) +
    ggtitle("Emissions from coal combustion-related sources") +
    geom_label(aes(fill = year), colour = "white", fontface = "bold")
dev.off()
