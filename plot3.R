# Importing the data
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

# reading Baltimore City data
Bal <- subset(NEI, NEI$fips == '24510')

# summarize the data by year and type
library(dplyr)

Bal_summary <- Bal %>%
    group_by(year, type) %>%
    summarise(total_emission = sum(Emissions, na.rm = TRUE))

# plot the data in four grids

library(ggplot2)

p <- ggplot(Bal_summary, aes(x = as.factor(year), y = total_emission, group = type)) +
    geom_line(aes(color = type)) +
    geom_point(aes(color = type)) +
    labs(title = "Emissions in Baltimore from 1999-2008 by Source Type",
         x = "Year",
         y = "Total Emissions") +
    facet_wrap(~ type, scales = "free_y") +
    theme_minimal()

print(p)




