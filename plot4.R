library( lubridate )
library( dplyr )
library( tidyr )

### read in the file
inData <- read.table( file="./data/household_power_consumption.txt",
                      sep=";",
                      header=TRUE,
                     stringsAsFactors = FALSE,
                     colClasses = c( rep( "character", 9 ) )
                    )

### subset to only 01/02/2017 and 02/02/2017
part1 <- subset( inData, Date=="1/2/2007" )
part2 <- subset( inData, Date=="2/2/2007" )
inData <- rbind( part1, part2 )

### check missing values
for( i in 1:9 ){
    print( sum( inData[i] == "?" ) )
}

### convert Numerical columns to numeric
for( i in 3:9 ){
    inData[[i]] <- as.numeric( inData[[i]] )
}

### make the datetime variable
inData$DTime <- paste(inData$Date, inData$Time)
inData$DTime <- dmy_hms( inData$DTime )

### FOURTH PLOT
png( "plot4.png", width=480, height=480 )
par( mfrow=c(2,2),
     mar=c(2,2,2,2)
    )

### top left
plot( x=inData$DTime,
     y=inData$Global_active_power,
     type="n",
     ylab="Global Active Power (kilowatts)",
     xlab=""
    )
lines( y=inData$Global_active_power, x=inData$DTime, type="l" )

### top right
plot( x=inData$DTime,
     y=inData$Voltage,
     type="n",
     ylab="Voltage",
     xlab=""
    )
lines( y=inData$Voltage, x=inData$DTime, type="l" )

### bottom left
plot(x=inData$DTime,
     y=inData$Sub_metering_1,
     type="n", ylab="Energy Sub Metering",
     xlab=""
    )
lines(x=inData$DTime, y=inData$Sub_metering_1, type="l", col="black")
lines(x=inData$DTime, y=inData$Sub_metering_2, type="l", col="red")
lines(x=inData$DTime, y=inData$Sub_metering_3, type="l", col="blue")
legend("topright",
       legend=c("Sub_merging_1", "Sub_merging_2", "Sub_merging_3"),
       col=c("black", "red", "blue"),
       lty=c(1,1,1)
      )


### bottom right
plot( x=inData$DTime,
     y=inData$Global_reactive_power,
     type="n",
     ylab="Global Reactive Power (kilowatts)",
     xlab=""
    )
lines( y=inData$Global_reactive_power, x=inData$DTime, type="l" )
dev.off()
