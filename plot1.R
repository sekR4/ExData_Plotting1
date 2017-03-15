############################################################
# Coursera: Exploratory Data Analysis: Course Project 1    #
#                                                          #
# The goal is to rebuild the 4 plots on                    #
# https://github.com/rdpeng/ExData_Plotting1               #
#                                                          #
# Author: Sebastian Kraus @ Chung-Ang University, Seoul    #
############################################################

gc()

WD <- getwd()
if (!is.null(WD)) setwd(WD)

#READING -----
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "data/dta.zip", method = "auto")
unzip("data/dta.zip", exdir = "data")

c.names <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
             "Voltage", "Global_intensity","Sub_metering_1", "Sub_metering_2", 
             "Sub_metering_3")

class. <- c("character", "character", "numeric", "numeric", "numeric", "numeric",
            "numeric", "numeric", "numeric")

dta <- read.table("data/household_power_consumption.txt",sep = ";", col.names = c.names, 
                  skip = 1, stringsAsFactors = FALSE, na.strings = "?", colClasses = class.)

dta <- subset(dta, dta$Date %in% c("1/2/2007","2/2/2007"))

dta <- dta[complete.cases(dta),]

# Transferring Date and Time into an POSIXct format saved as "dt"
library(lubridate)
dta$dt <- ymd_hms(
  paste(
    as.Date(dta$Date,"%d/%m/%Y")
    ,dta$Time))

# Plot 1 -----
with(data = dta,
     hist(Global_active_power, main = "Global Active Power", 
          xlab = "Global Active Power (kilowatts)", col = "red"))

dev.copy(png,"plot1.png",width=480, height=480); dev.off()