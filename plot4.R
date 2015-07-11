#read the whole data, define the class of each coloum.
datafirst<-read.table ('household_power_consumption.txt', header= TRUE, 
                      sep =";", na.strings='?',colClasses = c(rep('character',2), rep('numeric',7)))

#convert date coloumn to Date class and reassign.
datafirst$Date <-as.Date(datafirst$Date, "%d/%m/%Y")

#create the variable datam, a data frame that only has data from the designated dates.
datam<-subset(datafirst, mapply(function(x,y){x&&y}, 
                                (datafirst$Date<="2007-02-02"), (datafirst$Date>="2007-02-01")))

#Create a variable t that has both the time and the year information- needed to find Thu, Fri, Sat.
t <- mapply(function(x,y){paste(c(x,y), collapse = " ")}, 
         format(datam$Date, format = "%d/%m/%Y"), datam$Time)
t <- strptime(t, format="%d/%m/%Y %T")


par(mfrow=c(2,2))

#first plot
plot(x=t, y=datam$Global_active_power, ylab= "Global active power(kilowatts)", xlab='', type='l')

#second plot
plot(x=t, y=datam$Voltage,ylab="Voltage", xlab="datetime", type="l")

#third plot
plot(x=t, y=datam$Sub_metering_1, ylab= "Energy sub metering", xlab='', type='l', col="black")
lines (x=t, y=datam$Sub_metering_2, type="l", col="red")
lines (x=t, y=datam$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red", "blue"), 
       cex=0.6, lty=1,inset = 0.05, bty = "n")

#fourth plot
plot(x=t, y=datam$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")

dev.copy(png,"plot4.png")
dev.off()