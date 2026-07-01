Project is split into 4 R files that each make 1 image.  R files named the same as the png image they make.  They all assume the "Individual household electric power consumption Data Set" from the UC Irvine Machine Learning Repository is in the 'exdata_data_household_power_consumption' within the same folder.  This can be done by downloading the zip file from the link below and unzipping it in the same directory as the plotx.R files.


## DataSet

 - Electric Power Consumption: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

 -   Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.

The following descriptions of the 9 variables in the dataset are taken from the UCI web site:

  1.  Date: Date in format dd/mm/yyyy
  2.  Time: time in format hh:mm:ss
  3.  Global_active_power: household global minute-averaged active power (in kilowatt)
  4.  Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
  5.  Voltage: minute-averaged voltage (in volt)
  6.  Global_intensity: household global minute-averaged current intensity (in ampere)
  7.  Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
  8.  Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
  9. Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.


For analysis in 4 .R files only datapoints with Dates on February 1st or 2nd, 2007 were used.
