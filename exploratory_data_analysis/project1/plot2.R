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

power_cons$Global_active_power <- as.numeric(power_cons$Global_active_power)
png('plot2.png', width=480, height = 480)
plot(Global_active_power ~ as.numeric(Date_time), power_cons,
     ylab = 'Global Active Power (kilowatts)', xlab='',
     type='l', xaxt='n')
num_dt <- as.numeric(power_cons$Date_time)
axis(side = 1, at = c(min(num_dt), median(num_dt), max(num_dt)), labels = c("Thu", "Fri", "Sat"))
dev.off()
