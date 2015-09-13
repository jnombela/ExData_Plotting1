#
# Exploratory data analysis. Course project 1
# This script reproduces plot 1
#
plot1 <- function () {
#
# Packages
  require (data.table)
  require (dplyr)
#
# Load the data
  file <- fread("household_power_consumption.txt",sep=";",data.table = FALSE,colClasses = "dtnnnnnnn")
  data <- filter(file, Date=="1/2/2007"|Date=="2/2/2007")  # for efficiency
# transform the data
  data <- mutate(data, Global_active_power= as.numeric(Global_active_power))
#
# Make plot
  plot.new()
  hist(data$Global_active_power,main="Global Active Power",col="red",xlab="Global Active Power (kilowatts)")
#
# Generate plot on png device
  dev.copy(device=png,"plot1.png")
  dev.off()
}