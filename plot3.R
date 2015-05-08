d <- read.table(file="household_power_consumption.txt", sep=";",
                na.strings="?", header=TRUE)

# convert time to POSIXct format and select the time interval
d$datetime <- as.POSIXct(strptime(paste(d$Date, d$Time, sep=" "),
                                  format="%d/%m/%Y %H:%M:%S"))
t1 <- as.POSIXct("2007-02-01 00:00:00")
t2 <- as.POSIXct("2007-02-03 00:00:00")
d <- subset(d, select=c(-Date, -Time), subset = datetime >= t1 & datetime < t2)

# plot
png(filename="plot3.png", width=480, height=480)
par(bg="transparent")
with(d, { plot(datetime, Sub_metering_1, pch=NA, main=NULL,
               ylab="Energy sub metering", xlab="")
          lines(datetime, Sub_metering_1, col="black")
          lines(datetime, Sub_metering_2, col="red")
          lines(datetime, Sub_metering_3, col="blue") })
legend("topright", lty=c(1, 1, 1), col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
