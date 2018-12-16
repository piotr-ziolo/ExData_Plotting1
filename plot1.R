# PLOT 1


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
png(file = "plot1.png", width = 480, height = 480, bg = "transparent")

# Create the plot
hist(household_power_consumption$Global_active_power,
     col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# Close the connection
dev.off()
