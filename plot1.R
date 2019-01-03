# Calculate the number of rows to skip by substracting the desired time stamp from time in the first row  
first_row <- as.POSIXct("2006-12-16 17:24:00")
desired_time <- as.POSIXct("2007-02-01 00:00:00")
Rows_to_skip <- difftime(first_row,desired_time, units = "min")

#Read in the desired subset of data frame
Power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", skip = 66636, nrows = 2880)

# Create a vector with column headers and assign them to the data frame
headers <- c("Date","Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_", "Sub_metering_2", "Sub_metering_3")
colnames(Power) <- headers

#Create the first plot

png("plot1.png", width=480, height=480)
first <- hist(Power$Global_active_power, 
              breaks = seq(from = 0, to = 7.5, by =0.5), 
              main = "Global Active Power", col = "red", 
              xlab = "Global active power (kilowatts)")
dev.off()