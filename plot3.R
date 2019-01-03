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

#strip DateTime for the plot
datetimestripped <- strptime(paste(Power$Date, Power$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

#Converting Sub metering data to numeric
SM_1 <- as.numeric(Power$Sub_metering_)
SM_2 <- as.numeric(Power$Sub_metering_2)
SM_3 <- as.numeric(Power$Sub_metering_3)

#Create third plot
png("plot3.png", width=480, height=480)
Third <- plot(datetimestripped, SM_1, type="l", ylab="Energy sub metering", xlab="") 
  lines(datetimestripped, SM_2, type="l", col="red") 
  lines(datetimestripped, SM_3, type="l", col="blue") 
  legend("topright", c("Sub_metering_1 ", "Sub_metering_2", "Sub_metering_3"), 
         lty=1,
         lwd=2.5,
         col=c("black", "red", "blue"))
dev.off()
