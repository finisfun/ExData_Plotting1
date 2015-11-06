## Reading the text file into a dataframe and also replacing ? with NA
electricdata <- read.csv(unz("exdata-data-household_power_consumption.zip", "household_power_consumption.txt"), header=TRUE, sep=";", na.strings="?")

## Allocating the dataframe to another variable in order to avoid re-reading in case of issues
##  after transformation. Also excluding NA records
subelectricdata <- na.omit(electricdata)

## Transforming the date format
subelectricdata <- transform(subelectricdata, Date=strptime(Date, format='%d/%m/%Y'))

## creating a subset of the data for within the date ranges for faster processing
subdata <- subset(subelectricdata, (as.Date(Date) > '2007-01-31' & as.Date(Date) < '2007-02-03'))


## plot 1
png(file="plot1.png", width=480, height=480)
hist(subdata$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

