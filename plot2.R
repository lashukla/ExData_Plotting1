#Create a File Connection
dataFile <- "./data/household_power_consumption.txt"

#Read the file into Data Frame
data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

#Subset the data with specified dates
subSetData <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

#Convert active string as numeric
subSetData$Global_active_power <- as.numeric(subSetData$Global_active_power)

#Remove original data frame to free the unwanted data
rm(data)

#Create Data Time using Data and Time Columns
datetime <- strptime(paste(subSetData$Date, subSetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

#Create the png device for plot
png("plot2.png", width=480, height=480)

#Do the line plot using base plot
plot(datetime, subSetData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

#Close the device handle
dev.off()
