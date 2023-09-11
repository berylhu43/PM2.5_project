# Importing the data
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

# finding coal combustion related SCC
sec <- 'Fuel Comb.*Coal'
SCC_coal <- SCC[grep(sec, SCC$EI.Sector),]

# matching the SCC with emissions
NEI_coal_rows <- intersect(NEI$SCC, SCC_coal$SCC)
NEI_coal <- NEI[NEI$SCC %in% NEI_coal_rows,]

# grouping the emission by year
library(dplyr)
Comb_summary <- NEI_coal %>%
    group_by(year) %>%
    summarise(total_emission = sum(Emissions, na.rm = TRUE))

# plot the change of coal combustion related emissions
library(ggplot2)
p <- ggplot(Comb_summary, aes(x = as.factor(year), y = total_emission)) +
    geom_line(group=1) +
    geom_point() +
    labs(title = "Emissions in Coal Combustion from 1999-2008",
         x = "Year",
         y = "Coal Comb Emissions")

print(p)

