#
# Exploratory data analysis. Course project 1
# This script reproduces plot 4
#
plot4 <- function () {
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
  data <- mutate(data, Global_reactive_power= as.numeric(Global_reactive_power))
  data <- mutate(data, Voltage= as.numeric(Voltage))
  data <- mutate(data, Sub_metering_1= as.numeric(Sub_metering_1))
  data <- mutate(data, Sub_metering_2= as.numeric(Sub_metering_2))
  data <- mutate(data, Sub_metering_3= as.numeric(Sub_metering_3))
  data <- mutate(data, nTime=as.POSIXct(strptime(paste (Date,Time,sep=' '), "%d/%m/%Y %H:%M:%S")))
#
# Make the 4 plots
  plot.new()
  par(mfrow=c(2,2))   # layout for four plots into one canvas
# plot 1  
  plot(data$nTime, data$Global_active_power,type= 'S', col="black",xlab="", ylab="Global Active Power (kilowatts)")
# plot 2  
  plot(data$nTime, data$Voltage,type= 'S', col="black", xlab="datetime", ylab="Voltage")
# plot 3  
  with(data,plot(data$nTime, data$Sub_metering_1, type='n', xlab="", ylab="Energy sub metering"))
  legend("topright",pch='-',pt.cex = 2, cex=.75, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")
  with(data,points(data$nTime, data$Sub_metering_1, type= 'S', col="black"))
  with(data,points(data$nTime, data$Sub_metering_2, type= 'S', col="red"))
  with(data,points(data$nTime, data$Sub_metering_3, type= 'S', col="blue"))
# plot 4
  plot(data$nTime, data$Global_reactive_power,type= 'S', col="black", xlab="datetime", ylab="Global_reactive_power")
  
#
# Generate plot on png device
  dev.copy(device=png,"plot4.png")
  dev.off()
}