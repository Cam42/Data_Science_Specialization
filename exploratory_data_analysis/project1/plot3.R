data_path <- './exdata_data_household_power_consumption/household_power_consumption.txt'
power_cons <- read.csv2(data_path)
# creates date_time values which are a combination of Date and Time
power_cons$Date_time <- strptime(paste(power_cons$Date, power_cons$Time), 
                                 format = '%d/%m/%Y %H:%M:%S')
# Only keeps datapoints occurring within February 1-2, 2007
power_cons <- power_cons[
    (power_cons$Date_time >= strptime("01/02/2007 00:00:00",
                                      format = '%d/%m/%Y %H:%M:%S')) & 
        (power_cons$Date_time < strptime("03/02/2007 00:00:00",
                                         format = '%d/%m/%Y %H:%M:%S')), ]
# removes rows with NA values
power_cons <- power_cons[power_cons$Global_active_power != '?', ]
# turns sub meter data into numerica format
power_cons$Sub_metering_1 <- as.numeric(power_cons$Sub_metering_1)
power_cons$Sub_metering_2 <- as.numeric(power_cons$Sub_metering_2)
power_cons$Sub_metering_3 <- as.numeric(power_cons$Sub_metering_3)
# where plot goes
png('plot3.png', width=480, height = 480)
# 3 sub meter line plots
plot(Sub_metering_1 ~ as.numeric(Date_time), power_cons,
     ylab = 'Energy sub metering', xlab='',
     type='l', xaxt='n', col = 'black')
lines(Sub_metering_2 ~ as.numeric(Date_time), power_cons, 
      col = 'orange')
lines(Sub_metering_3 ~ as.numeric(Date_time), power_cons, 
      col = 'blue')
num_dt <- as.numeric(power_cons$Date_time)
# adds x-axis of Thu, Fri, and Sat
axis(side = 1, at = c(min(num_dt), median(num_dt), max(num_dt)), labels = c("Thu", "Fri", "Sat"))
legend("topright",
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       lty = 1, col = c('black', 'orange', 'blue'))
dev.off()
