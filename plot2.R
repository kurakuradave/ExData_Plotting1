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

### SECOND PLOT - LINEPLOT 
### make the datetime variable
inData$DTime <- paste(inData$Date, inData$Time)
inData$DTime <- dmy_hms( inData$DTime )

png( "plot2.png", width=480, height=480 )
plot( x=inData$DTime,
     y=inData$Global_active_power,
     type="n",
     ylab="Global Active Power (kilowatts)",
     xlab=""
    )
lines( y=inData$Global_active_power, x=inData$DTime, type="l" )
dev.off()

