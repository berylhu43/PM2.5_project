# Importing the data
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")


# reading Baltimore City data
Bal <- subset(NEI, NEI$fips == '24510')
Bal_1999 <- subset(Bal, Bal$year == '1999')
Bal_2002 <- subset(Bal, Bal$year == '2002')
Bal_2005 <- subset(Bal, Bal$year == '2005')
Bal_2008 <- subset(Bal, Bal$year == '2008')

# Finding the total emission of PM2.5 in Baltimore City in the four years
Bal_sum_1999 <- sum(Bal_1999$Emissions, na.rm = TRUE)
Bal_sum_2002 <- sum(Bal_2002$Emissions, na.rm = TRUE)
Bal_sum_2005 <- sum(Bal_2005$Emissions, na.rm = TRUE)
Bal_sum_2008 <- sum(Bal_2008$Emissions, na.rm = TRUE)

#Vector of sum of each year of Baltimore 
sum_Bal <- c(Bal_sum_1999, Bal_sum_2002, Bal_sum_2005, Bal_sum_2008)

#Create a plot showing the change in Baltimore City PM2.5 emission
plot(years, sum_Bal, type="b", 
     xlab="Year", ylab="Total PM2.5 Emissions", 
     main="PM2.5 Emissions Over Time in Baltimore City",
     pch=19, col="blue", lty=1, lwd=2)
grid(col = "gray")