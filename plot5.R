# Importing the data
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

# finding motor vehicle related SCC
sec <- 'Motorcycles'
SCC_motor <- SCC[grep(sec, SCC$Short.Name),]

# reading data of Baltimore City
Bal <- subset(NEI, NEI$fips == '24510')

# matching the SCC with emissions in Baltimore
Bal_motor_rows <- intersect(Bal$SCC, SCC_motor$SCC)
Bal_motor <- Bal[Bal$SCC %in% Bal_motor_rows,]

# group the emission by years
library(dplyr)
Motor_summary <- Bal_motor %>%
    group_by(year) %>%
    summarise(total_emission = sum(Emissions, na.rm = TRUE))

# plot the change of emission in Baltimore City in motor vehicles related sources
library(ggplot2)
p <- ggplot(Motor_summary, aes(x = as.factor(year), y = total_emission)) +
    geom_line(group=1) +
    geom_point() +
    labs(title = "Emissions from Motor Vehicles from 1999-2008",
         x = "Year",
         y = "Motor Vehicles Emissions")

print(p)

# reading data of Los Angeles
LA <- subset(NEI, NEI$fips == '06037')

# matching the SCC with emissions in LA
LA_motor_rows <- intersect(LA$SCC, SCC_motor$SCC)
LA_motor <- LA[LA$SCC %in% LA_motor_rows,]

# group the emission by years
Motor_summary_LA <- LA_motor %>%
    group_by(year) %>%
    summarise(total_emission = sum(Emissions, na.rm = TRUE))

# Adding a city column to differentiate the data
Motor_summary$city <- "Baltimore"
Motor_summary_LA$city <- "Los Angeles"

# Combining the two datasets
combined_data <- rbind(Motor_summary, Motor_summary_LA)

# Plotting the combined data with differentiation for the two cities
p_combined <- ggplot(combined_data, aes(x = as.factor(year), y = total_emission, color = city)) +
    geom_line(aes(group=city)) + 
    geom_point() +
    labs(title = "Emissions from Motor Vehicles from 1999-2008: Baltimore vs. Los Angeles",
         x = "Year",
         y = "Motor Vehicles Emissions") +
    theme_minimal() +
    scale_color_manual(values = c("Baltimore" = "blue", "Los Angeles" = "red"))

print(p_combined)



