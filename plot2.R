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

# Creating the plot2:
png("plot2.png", width = 480, height = 480)
plot(newconsump$datetime, newconsump$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

# disconnecting from png graphic device
dev.off()