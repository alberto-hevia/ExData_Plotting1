# read the whole matrix into dataSet
dataSet = read.table("household_power_consumption.txt", sep = ";", header = TRUE,
                     stringsAsFactors = FALSE)

# convert date to Date
dataSet$Date <- strptime(dataSet$Date,"%d/%m/%Y")

# filter data to obtain only days 1 and 2 of 02/2007
filData <- subset(dataSet, 
                  dataSet$Date %in% c(strptime("01/02/2007","%d/%m/%Y"),strptime("02/02/2007","%d/%m/%Y")))

# Conver the Global_active_power to number
filData$Global_active_power <- as.numeric(filData$Global_active_power)

# Create the x axis with the date and time
datetime <- strptime(paste(filData$Date, filData$Time),"%Y-%m-%d %H:%M:%S")

# put the local lenguage to english
Sys.setlocale(locale = "C")

par(cex.lab = 0.8, cex.axis = 0.8, cex.main = 0.8)

# plot the graph: only axes
plot(datetime , filData$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
# plot the lines
lines(datetime , filData$Global_active_power)

dev.copy(png, file ="plot2.png", width = 480 , height = 480)
dev.off()
