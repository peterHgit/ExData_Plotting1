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
dat <- dat[dat$Date == "2007-2-1" | dat$Date == "2007-2-2", ]

#Combining Date and Time

DateTime <- as.POSIXct(paste(dat$Date, dat$Time))
dat <- cbind(DateTime, dat)
dat <- subset(dat, select = -c(Date, Time) )

# Plotting
## preserve current local and change to english local
my_locale <- Sys.getlocale("LC_ALL")
Sys.setlocale("LC_ALL", "English")

with(dat, plot(x = DateTime, 
               y = Global_active_power, 
               type = "l", 
               xlab = "",
               ylab = "Global Active Powers (kilowatts)"))

## restore own local
Sys.setlocale("LC_ALL", my_locale)
