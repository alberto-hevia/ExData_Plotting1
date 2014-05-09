# read the whole matrix into dataSet
dataSet = read.table("household_power_consumption.txt", sep = ";", header = TRUE,
                     stringsAsFactors = FALSE)

# convert date to Date
dataSet$Date <- strptime(dataSet$Date,"%d/%m/%Y")

# filter data to obtain only days 1 and 2 of 02/2007
filData <- subset(dataSet, 
                  dataSet$Date %in% c(strptime("01/02/2007","%d/%m/%Y"),strptime("02/02/2007","%d/%m/%Y")))

# Conver the columns to be shown to numeric
filData$Global_active_power <- as.numeric(filData$Global_active_power)
filData$Voltage <- as.numeric(filData$Voltage)
filData$Sub_metering_1 <- as.numeric(filData$Sub_metering_1)
filData$Sub_metering_2 <- as.numeric(filData$Sub_metering_2)
filData$Sub_metering_3 <- as.numeric(filData$Sub_metering_3)
filData$Global_reactive_power <- as.numeric(filData$Global_reactive_power)

# Create the x axis with the date and time
datetime <- strptime(paste(filData$Date, filData$Time),"%Y-%m-%d %H:%M:%S")

# put the local lenguage to english
Sys.setlocale(locale = "C")

# lets paint the graphs

# a panel of 2,2
par(mfrow=c(2,2), cex.lab = 0.7, cex.axis = 0.7)

# Global Active Power
plot(datetime , filData$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power")
lines(datetime , filData$Global_active_power)

# Voltage
plot(datetime , filData$Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
lines(datetime , filData$Voltage)

# SubMetering
plot(datetime , filData$Sub_metering_1, type = "n", xlab = "", 
     ylab = "Energy sub metering")

# plot the lines with one of each sub metering
lines(datetime , filData$Sub_metering_1, col = "black")
lines(datetime , filData$Sub_metering_2, col = "red")
lines(datetime , filData$Sub_metering_3, col = "blue")

legend("topright", cex=0.7, lty = 1, 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")

# Global Reactive Power
plot(datetime , filData$Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
lines(datetime , filData$Global_reactive_power)

dev.copy(png, file ="plot4.png", width = 480 , height = 480)
dev.off()
