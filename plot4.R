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

par(mfcol = c(2,2))

## plot 1 (top left)
with(dat, plot(x = DateTime, 
               y = Global_active_power, 
               type = "l", 
               xlab = "",
               ylab = "Global Active Powers")
     )

## plot 2 (bottom left)
with(dat, {
        plot(x = DateTime, 
             y = Sub_metering_1, 
             type = "l", 
             xlab = "",
             ylab = "Energy sub metering")
        lines(x = DateTime,
              y = Sub_metering_2,
              col = "red")
        lines(x = DateTime,
              y = Sub_metering_3,
              col = "blue")
        legend("topright",
               col = c("black", "red", "blue"),
               bty = "n",
               lty = c(1,1),
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        }
     )

## plot 3 (top right)
with(dat, plot(x = DateTime,
               y = Voltage,
               type = "l",
               xlab = "datetime",
               yaxt = "n"))
          axis(side = 2, 
               at = c(234, 236, 238, 240, 242, 244, 246), 
               labels = c("234", "", "238", "", "242", "", "246"))

## plot 4 (bottom right)
with(dat, plot(x = DateTime,
               y = Global_reactive_power,
               type = "l",
               xlab = "datetime"))

## restore own local
Sys.setlocale("LC_ALL", my_locale)
