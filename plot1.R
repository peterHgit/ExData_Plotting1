# Getting the data into R

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "data.zip", mode = "wb")
unzip("data.zip")
unlink("data.zip")
dateDownloaded <- date()

rawdat <-read.table("household_power_consumption.txt", 
                    header = TRUE, 
                    sep = ";", 
                    na.strings = "?")


# Filtering the two days

dat <- rawdat
dat$Date <- as.Date(dat$Date, "%d/%m/%Y")
dat2 <- dat[dat$Date == "2007-2-1" | dat$Date == "2007-2-2", ]

# Plotting

hist(dat2$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")