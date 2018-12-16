# PLOT 4


# Download the data if it does not already exist in the working directory and unzip it
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileZipped <- "./exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileUnzipped <- "./household_power_consumption.txt"

if(!file.exists(fileZipped)) {
    download.file(fileUrl, destfile = fileZipped, method = "curl")
}

if (!file.exists(fileUnzipped)) { 
    unzip(fileZipped) 
}

# Load, subset and transform the data
household_power_consumption <- read.table(fileUnzipped, header = TRUE, sep = ";",
                                          na.strings = "?" ,stringsAsFactors = FALSE)

household_power_consumption <- subset(household_power_consumption, 
                                      Date == "1/2/2007" | Date == "2/2/2007")

household_power_consumption$DateTime <- strptime(paste(household_power_consumption$Date,
                                                       household_power_consumption$Time),
                                                 "%d/%m/%Y %H:%M:%S")

household_power_consumption$Date <- as.Date(household_power_consumption$Date, "%d/%m/%Y")

# Create the png file
png(file = "plot4.png", width = 480, height = 480, bg = "transparent")

# Set graphical parameters
par(mfcol = c(2,2))

# Create the plot
with(household_power_consumption, {
    
    # Plot 1
    plot(DateTime, Global_active_power,
         type = "l",
         xlab = "",
         ylab = "Global Active Power (kilowatts)")
    
    # Plot 2
    plot(DateTime, Sub_metering_1,
         type = "l",
         xlab = "",
         ylab = "Energy sub metering")
    lines(DateTime, Sub_metering_2, col = "red")
    lines(DateTime, Sub_metering_3, col = "blue")
    legend(x = "topright",
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           col = c("black", "red", "blue"),
           lty = 1,
           bty = "n")
    
    # Plot 3
    plot(DateTime, Voltage,
         type = "l",
         xlab = "datetime",
         ylab = "Voltage")
    
    # Plot 4
    plot(DateTime, Global_reactive_power,
         type = "l",
         xlab = "datetime",
         ylab = "Global_reactive_power")
    
})

# Close the connection
dev.off()
