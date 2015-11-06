## Reading the text file into a dataframe and also replacing ? with NA
electricdata <- read.csv(unz("exdata-data-household_power_consumption.zip", "household_power_consumption.txt"), header=TRUE, sep=";", na.strings="?")

## Allocating the dataframe to another variable in order to avoid re-reading in case of issues
##  after transformation. Also excluding NA records
subelectricdata <- na.omit(electricdata)

## Transforming the date format
subelectricdata <- transform(subelectricdata, Date=strptime(Date, format='%d/%m/%Y'))

## creating a subset of the data for within the date ranges for faster processing
subdata <- subset(subelectricdata, (as.Date(Date) > '2007-01-31' & as.Date(Date) < '2007-02-03'))

subdata$datetime <- format(as.POSIXct(paste(subdata$Date, subdata$Time)), "%Y-%m-%d %H:%M:%S")

daterange <- c(as.POSIXct('2007-02-01 00:00:00', format="%Y-%m-%d %H:%M:%S"), 
               as.POSIXct('2007-02-03 00:00:00', format="%Y-%m-%d %H:%M:%S"))

## plot 4
png(file="plot4.png", width=480, height=480)
# plotting the graph 1,1
par(mfrow=c(2,2))

with(subdata, {
  plot(as.POSIXct(datetime, format="%Y-%m-%d %H:%M:%S"), 
                   Global_active_power, type="n", xlim=daterange, xlab="", 
                   ylab="Global Active Power")

  lines(as.POSIXct(datetime, format="%Y-%m-%d %H:%M:%S"), 
                    Global_active_power)
  axis(side=2, lwd=2)
}
)

# plotting the graph 1,2
with(subdata, {
  plot(as.POSIXct(datetime, format="%Y-%m-%d %H:%M:%S"), 
                   Voltage, type="n", xlim=daterange, xlab="datetime", 
                   ylab="Voltage")

  lines(as.POSIXct(datetime, format="%Y-%m-%d %H:%M:%S"), 
                    Voltage)
  axis(side=2, lwd=2)
}
)

# plotting the graph 2,1
with(subdata, {
  plot(as.POSIXct(datetime, format="%Y-%m-%d %H:%M:%S"), 
                   Sub_metering_1, type="n", xlim=daterange, ylim=c(0,38), xlab="", 
                   ylab="Energy sub metering")
##  plot(as.POSIXct(datetime, format="%Y-%m-%d %H:%M:%S"), 
##                   Sub_metering_2, type="n", xlim=daterange, ylim=c(0,38), xlab="", 
##                   ylab="Energy sub metering", col="red")
##  plot(as.POSIXct(datetime, format="%Y-%m-%d %H:%M:%S"), 
##                   Sub_metering_3, type="n", xlim=daterange, ylim=c(0,38), xlab="", 
##                   ylab="Energy sub metering", col="blue")
  lines(as.POSIXct(datetime, format="%Y-%m-%d %H:%M:%S"), 
                    Sub_metering_1, col="black")
  lines(as.POSIXct(datetime, format="%Y-%m-%d %H:%M:%S"), 
                    Sub_metering_2, col="red")
  lines(as.POSIXct(datetime, format="%Y-%m-%d %H:%M:%S"), 
                    Sub_metering_3, col="blue")
  legend("topright", lwd=1, col=c("black", "red", "blue"), bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  axis(side=2, lwd=2)
}
)

# plotting the graph 2,2
with(subdata, {
  plot(as.POSIXct(datetime, format="%Y-%m-%d %H:%M:%S"), 
                   Global_reactive_power, type="n", xlim=daterange, xlab="datetime", 
                   ylab="Global_reactive_power")

  lines(as.POSIXct(datetime, format="%Y-%m-%d %H:%M:%S"), 
                    Global_reactive_power)
  axis(side=2, lwd=2)
}
)


# closing device
dev.off()

