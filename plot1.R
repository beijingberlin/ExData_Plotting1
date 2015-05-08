d <- read.table(file="household_power_consumption.txt", sep=";",
                na.strings="?", header=TRUE)

# convert time to POSIXct format and select the time interval
d$datetime <- as.POSIXct(strptime(paste(d$Date, d$Time, sep=" "),
                                  format="%d/%m/%Y %H:%M:%S"))
t1 <- as.POSIXct("2007-02-01 00:00:00")
t2 <- as.POSIXct("2007-02-03 00:00:00")
d <- subset(d, select=c(-Date, -Time), subset = datetime >= t1 & datetime < t2)

# plot
png(filename="plot1.png", width=480, height=480)
par(bg="transparent")
with(d, hist(Global_active_power, col="red", main="Global Active Power",
             xlab="Global Active Power (kilowatts)"))
dev.off()
