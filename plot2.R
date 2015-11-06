## Reading the text file into a dataframe and also replacing ? with NA
electricdata <- read.csv(unz("exdata-data-household_power_consumption.zip", "household_power_consumption.txt"), header=TRUE, sep=";", na.strings="?")

## Allocating the dataframe to another variable in order to avoid re-reading in case of issues
##  after transformation. Also excluding NA records
subelectricdata <- na.omit(electricdata)

## Transforming the date format
subelectricdata <- transform(subelectricdata, Date=strptime(Date, format='%d/%m/%Y'))

## creating a subset of the data for within the date ranges for faster processing
subdata <- subset(subelectricdata, (as.Date(Date) > '2007-01-31' & as.Date(Date) < '2007-02-03'))


## plot 2
# adding a new column with date time
subdata$datetime <- format(as.POSIXct(paste(subdata$Date, subdata$Time)), "%Y-%m-%d %H:%M:%S")

daterange <- c(as.POSIXct('2007-02-01 00:00:00', format="%Y-%m-%d %H:%M:%S"), 
               as.POSIXct('2007-02-03 00:00:00', format="%Y-%m-%d %H:%M:%S"))

# plotting the graph
png(file="plot2.png", width=480, height=480)
with(subdata, plot(as.POSIXct(datetime, format="%Y-%m-%d %H:%M:%S"), 
                   Global_active_power, type="n", xlim=daterange, xlab="", 
                   ylab="Global Active Power (kilowatts)"))

with(subdata, lines(as.POSIXct(datetime, format="%Y-%m-%d %H:%M:%S"), 
                   Global_active_power))

axis(side=2, lwd=2)

dev.off()