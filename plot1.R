#read the whole data, define the class of each coloum.
datafirst<-read.table ('household_power_consumption.txt', header= TRUE, 
          sep =";", na.strings='?',colClasses = c(rep('character',2), rep('numeric',7)))

#convert date coloumn to Date class and reassign.
datafirst$Date <-as.Date(datafirst$Date, "%d/%m/%Y")

#create the variable datam, a data frame that only has data from the designated dates.
datam<-subset(datafirst, mapply(function(x,y){x&&y}, 
      (datafirst$Date<="2007-02-02"), (datafirst$Date>="2007-02-01")))

hist(datam$Global_active_power, breaks=12,main='Global active power', 
     xlab="Global active power (kilowatts)", ylab="frequency", col='red')

dev.copy(png,"plot1.png")
dev.off













#datefirst <-read.table('household_power_consumption.txt', header= TRUE, 
#                       sep =";", colClasses = c("character", rep ("NULL", 8)))
#indexim<- which(datefirst$Date %in% c("1/2/2007", '2/2/2007'))