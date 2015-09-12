#Create a File Connection
dataFile <- "./data/household_power_consumption.txt"

#Read the file into Data Frame
data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

#Subset the data with specified dates
subSetData <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

#Remove original data frame to free the unwanted data
rm(data)

#Convert active string as numeric
subSetData$Global_active_power <- as.numeric(subSetData$Global_active_power)

subSetData$Sub_metering_1 <- as.numeric(subSetData$Sub_metering_1)
subSetData$Sub_metering_2 <- as.numeric(subSetData$Sub_metering_2)
subSetData$Sub_metering_3 <- as.numeric(subSetData$Sub_metering_3)
subSetData$Voltage <- as.numeric(subSetData$Voltage)
subSetData$Global_reactive_power <- as.numeric(subSetData$Global_reactive_power)

#Create Data Time using Data and Time Columns
datetime <- strptime(paste(subSetData$Date, subSetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

#Create the png device for plot
png("plot4.png", width=480, height=480)

#Create 2*2 = 4 plots in the grid row-wise
par(mfrow = c(2, 2))

#Do the line plot 
plot(datetime, subSetData$Global_active_power , type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(datetime, subSetData$Voltage , type="l", xlab="datetime", ylab="Voltage")

#Do the line plot using base plot
plot(datetime, subSetData$Sub_metering_1 , type="l", ylab="Energy Submetering", xlab="")

#Annotate the plot with SubMeter2 and Submeter3
lines(datetime, subSetData$Sub_metering_2, type="l", col="red")
lines(datetime, subSetData$Sub_metering_3, type="l", col="blue")

#Annotate the legend with the plot 
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

#Plot the Reactive Power
plot(datetime, subSetData$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

#Close the device handle
dev.off()
