d <- read.table(file="household_power_consumption.txt", sep=";",
                na.strings="?", header=TRUE)

# convert time to POSIXct format and select the time interval
d$datetime <- as.POSIXct(strptime(paste(d$Date, d$Time, sep=" "),
                                  format="%d/%m/%Y %H:%M:%S"))
t1 <- as.POSIXct("2007-02-01 00:00:00")
t2 <- as.POSIXct("2007-02-03 00:00:00")
d <- subset(d, select=c(-Date, -Time), subset = datetime >= t1 & datetime < t2)

# plot
png(filename="plot4.png", width=480, height=480)
par(bg="transparent", mfrow=c(2, 2))
with(d, { plot(datetime, Global_active_power, type="l",
               ylab="Global Active Power (kilowatts)", xlab="")
          plot(datetime, Voltage, type="l")
          plot(datetime, Sub_metering_1, pch=NA,
               ylab="Energy sub metering", xlab="")
          lines(datetime, Sub_metering_1, col="black")
          lines(datetime, Sub_metering_2, col="red")
          lines(datetime, Sub_metering_3, col="blue")
          legend("topright", lty=c(1, 1, 1), bty="n",
                 col=c("black", "red", "blue"),
                 legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
          plot(datetime, Global_reactive_power, type="l")
      })
dev.off()
