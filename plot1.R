# Importing the data
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

# subsetting the table into four table based on years
data_1999 <- subset(NEI, NEI$year == '1999')
data_2002 <- subset(NEI, NEI$year == '2002')
data_2005 <- subset(NEI, NEI$year == '2005')
data_2008 <- subset(NEI, NEI$year == '2008')

# sum total PM2.5 emmision in each year
sum_1999 <- sum(data_1999$Emissions)
sum_2002 <- sum(data_2002$Emissions)
sum_2005 <- sum(data_2005$Emissions)
sum_2008 <- sum(data_2008$Emissions)

# Create a vector of years and a vector of the sums for each year
years <- c(1999, 2002, 2005, 2008)
sums <- c(sum_1999, sum_2002, sum_2005, sum_2008)

# Use the plot function to create the plot
plot(years, sums, type="b", 
     xlab="Year", ylab="Total PM2.5 Emissions", 
     main="PM2.5 Emissions Over Time",
     pch=19, col="blue", lty=1, lwd=2)

# Add a grid for better readability
grid(col = "gray")








