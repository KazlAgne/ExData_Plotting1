# Calculate the number of rows to skip by substracting the desired time stamp from time in the first row  
first_row <- as.POSIXct("2006-12-16 17:24:00")
desired_time <- as.POSIXct("2007-02-01 00:00:00")
Rows_to_skip <- difftime(first_row,desired_time, units = "min")

#Read in the desired subset of data frame
Power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", skip = 66636, nrows = 2880)

# Create a vector with column headers and assign them to the data frame
headers <- c("Date","Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_", "Sub_metering_2", "Sub_metering_3")
colnames(Power) <- headers

# Create a new DateTime column
Power$DateTime <- as.POSIXct(as.character(paste(Power$Date, Power$Time)), format="%d/%m/%Y %H:%M:%OS")

png("plot2.png", width=480, height=480)
Second <<- graphics::plot.default(
  x = Power$DateTime,
  y = Power$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power (kilowatts)")
dev.off()