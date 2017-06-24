# file needs to be located in the following working directory
#"C:/Users/thomas.pham@lamresearch.com/Downloads/Coursera/Exploratory Data/Week1"

library(dplyr)

#freeing up memory by clearing out the current buffer
rm(list=ls())
#reading data into R:
bigconsump<- read.table("hh_pwr_con.txt", sep=";",, header=TRUE, quote= "", strip.white=TRUE, stringsAsFactors = FALSE, na.strings= "?")

# subsetting the full data to obtain the to two desired days of feb 1, and feb 2, 2007: 
newconsump<- subset(bigconsump, Date == "1/2/2007" | Date== "2/2/2007") 
# Changing the class of Date variable from character to Date: 
newconsump$Date <- as.Date(newconsump$Date, format = "%d/%m/%Y")
# creating a new column combining date and time
newconsump<- mutate(newconsump, datetime=paste(Date, Time))
# converting datetime col into date time format for plotting.
newconsump$datetime<-as.POSIXlt(newconsump$datetime)

# Creating the plot4:
png("plot4.png", width = 480, height = 480)
# setup a matrix of 2 row, 2 col charts
par(mfrow=c(2,2))
# plotting the first to first row, first column
plot(newconsump$datetime, newconsump$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# adding 2nd chart to first row, second column
plot(newconsump$datetime, newconsump$Voltage, type="l", xlab="datetime", ylab="Voltage")

# adding 3rd chart to 2nd row, first column
plot(newconsump$datetime, newconsump$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
# adding additional data to the 3rd chart
points(newconsump$datetime, newconsump$Sub_metering_2, type="l")
points(newconsump$datetime, newconsump$Sub_metering_2, type="l", col="red")
points(newconsump$datetime, newconsump$Sub_metering_3, type="l", col="blue")
# adding the legend to the 3rd chart
legend("topright", lty = 1, lwd = 1, bty="n", col=c("black","red", "blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# adding 4th chart to 2nd row, 2nd col
plot(newconsump$datetime, newconsump$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# disconnecting from png graphic device
dev.off()