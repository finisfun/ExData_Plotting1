## Reading the text file into a dataframe and also replacing ? with NA
electricdata <- read.csv(unz("exdata-data-household_power_consumption.zip", "household_power_consumption.txt"), header=TRUE, sep=";", na.strings="?")

## Allocating the dataframe to another variable in order to avoid re-reading in case of issues
##  after transformation. Also excluding NA records
subelectricdata <- na.omit(electricdata)

## Transforming the date format
subelectricdata <- transform(subelectricdata, Date=strptime(Date, format='%d/%m/%Y'))

## creating a subset of the data for within the date ranges for faster processing
subdata <- subset(subelectricdata, (as.Date(Date) > '2007-01-31' & as.Date(Date) < '2007-02-03'))

## creating a date time column combining Date and Time column values
subdata$datetime <- format(as.POSIXct(paste(subdata$Date, subdata$Time)), "%Y-%m-%d %H:%M:%S")


## plot 3
daterange <- c(as.POSIXct('2007-02-01 00:00:00', format="%Y-%m-%d %H:%M:%S"), 
               as.POSIXct('2007-02-03 00:00:00', format="%Y-%m-%d %H:%M:%S"))

## open device
png(file="plot3.png", width=480, height=480)

## creating empty frame
with(subdata, plot(as.POSIXct(datetime, format="%Y-%m-%d %H:%M:%S"), 
                   Sub_metering_1, type="n", xlim=daterange, ylim=c(0,38), xlab="", 
                   ylab="Energy sub metering"))
with(subdata, plot(as.POSIXct(datetime, format="%Y-%m-%d %H:%M:%S"), 
                   Sub_metering_2, type="n", xlim=daterange, ylim=c(0,38), xlab="", 
                   ylab="Energy sub metering", col="red"))
with(subdata, plot(as.POSIXct(datetime, format="%Y-%m-%d %H:%M:%S"), 
                   Sub_metering_3, type="n", xlim=daterange, ylim=c(0,38), xlab="", 
                   ylab="Energy sub metering", col="blue"))

## plotting lines
with(subdata, lines(as.POSIXct(datetime, format="%Y-%m-%d %H:%M:%S"), 
                    Sub_metering_1, col="black"))
with(subdata, lines(as.POSIXct(datetime, format="%Y-%m-%d %H:%M:%S"), 
                    Sub_metering_2, col="red"))
with(subdata, lines(as.POSIXct(datetime, format="%Y-%m-%d %H:%M:%S"), 
                    Sub_metering_3, col="blue"))

## setting legend
legend("topright", lwd=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## setting axis width
axis(side=2, lwd=2)

dev.off()