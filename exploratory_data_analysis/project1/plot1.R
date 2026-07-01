data_path <- './exdata_data_household_power_consumption/household_power_consumption.txt'
power_cons <- read.csv2(data_path)
# turns date values into Date datetype
power_cons$Date <- as.Date(power_cons$Date, format = '%d/%m/%Y')
# Only keeps datapoints occurring from February 1-2, 2007
power_cons <- power_cons[
    (power_cons$Date >= as.Date("01/02/2007", format = '%d/%m/%Y')) & 
    (power_cons$Date <= as.Date("02/02/2007", format = '%d/%m/%Y')), ]
# removes rows with NA values
power_cons <- power_cons[power_cons$Global_active_power != '?', ]

power_cons$Global_active_power <- as.numeric(power_cons$Global_active_power)
png('plot1.png', width=480, height = 480)
hist(power_cons$Global_active_power, col = 'red', main = 'Global Active Power',
     xlab = 'Global Active Power (kilowatts)')
dev.off()
