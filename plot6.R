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

#6.	Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle 
# sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?
California_onRoad <- subset(NEI, NEI$fips == "06037" & NEI$type == "ON-ROAD")

Baltimore1 <- summarise(group_by(Baltimore_onRoad, year), Emissions = sum(Emissions))
California <- summarise(group_by(California_onRoad, year), Emissions = sum(Emissions))

Baltimore1$County <- "Baltimore City, MD"
California$County <- "Los Angeles County, CA"

Both.County <- rbind(Baltimore1, California)
Change_byYear <- Both.County %>% group_by(County) %>% 
    mutate(prop_change_percentage = ((c(0, diff(Emissions)))/Emissions)*100)
png("plot6a.png", width = 480, height = 480)
ggplot(Both.County, aes(x = factor(year), y = Emissions, fill = County, label = round(Emissions,2))) + 
    scale_fill_manual(values = c("firebrick3", "gold")) + 
    geom_bar(stat = "identity") + 
    facet_grid(County~., scales = "free") +
    ylab(expression("total PM"[2.5]*" emissions in tons")) + 
    xlab("year") +
    ggtitle(expression("Motor vehicle emission variation in Baltimore and Los Angeles")) +
    geom_label(aes(fill = County),colour = "black", fontface = "bold")
dev.off()
png("plot6b.png", width = 480, height = 480)
ggplot(Change_byYear, aes(x = factor(year), y = prop_change_percentage, fill = County, label = round(prop_change_percentage,2))) + 
    scale_fill_manual(values = c("firebrick3", "gold")) + 
    geom_bar(stat = "identity") + 
    facet_grid(County~., scales = "free") +
    ylab(expression("Change in PM"[2.5]*" emissions from previous year in %")) + 
    xlab("year") +
    ggtitle(expression("Proportional changes in consecutive years in percentage points")) +
    geom_label(aes(fill = County),colour = "black", fontface = "bold")
dev.off()
