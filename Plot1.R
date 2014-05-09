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

par(cex.lab = 0.7, cex.axis = 0.7, cex.main = 0.9)

# paint the histogram: x label, main and colour.
hist(filData$Global_active_power,xlab = "Global Active Power (kilowatts)",main = "Global Active Power", col="red")

dev.copy(png, file ="plot1.png", width = 480 , height = 480)
dev.off()
