# read the whole matrix into dataSet
dataSet = read.table("household_power_consumption.txt", sep = ";", header = TRUE,
                     stringsAsFactors = FALSE)

# convert date to Date
dataSet$Date <- strptime(dataSet$Date,"%d/%m/%Y")

# filter data to obtain only days 1 and 2 of 02/2007
filData <- subset(dataSet, 
                  dataSet$Date %in% c(strptime("01/02/2007","%d/%m/%Y"),strptime("02/02/2007","%d/%m/%Y")))

# Conver the columns to be shown to numeric
filData$Sub_metering_1 <- as.numeric(filData$Sub_metering_1)
filData$Sub_metering_2 <- as.numeric(filData$Sub_metering_2)
filData$Sub_metering_3 <- as.numeric(filData$Sub_metering_3)

# Create the x axis with the date and time
datetime <- strptime(paste(filData$Date, filData$Time),"%Y-%m-%d %H:%M:%S")

# put the local lenguage to english
Sys.setlocale(locale = "C")

# plot the graph: only axes
plot(datetime , filData$Sub_metering_1, type = "n", xlab = "", 
     ylab = "Energy sub metering")

# plot the lines with one of each sub metering
lines(datetime , filData$Sub_metering_1, col = "black")
lines(datetime , filData$Sub_metering_2, col = "red")
lines(datetime , filData$Sub_metering_3, col = "blue")

legend("topright", cex=0.7, lty = 1, 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file ="plot3.png", width = 480 , height = 480)
dev.off()
