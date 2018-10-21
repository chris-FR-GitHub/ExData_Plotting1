################################################################################
## Coursera :       Johns Hopkins
## Specialization : Data Science 
## Course #04 :     Exploratory Data Analysis
################################################################################
## Week 1 - Programming Assignment #1
## GitHub : Chris-FR-GitHib
################################################################################
#
#                         plot2.R
#
################################################################################



################################################################################
# R library

# clear the objects
# ls()
# rm(list=ls())

# Load the packages
library(dplyr, warn.conflicts = FALSE)
library(readr)   # for read_table > tibble
library(lubridate, warn.conflicts = FALSE)


################################################################################
# reading the data
# using the readr package 'tibble output)

hpc <- read_delim('household_power_consumption.txt',
                  delim=";",
                  col_names=TRUE,
                  col_types = list(
                      col_date(format="%d/%m/%Y"), 
                      col_time(),
                      col_double(),
                      col_double(),
                      col_double(),
                      col_double(),
                      col_double(),
                      col_double(),
                      col_double()),
                  na = c("?", "NA"))

################################################################################
# Filter dates : between 2007-02-01 and 2007-02-02
hpc <- hpc %>% 
    filter(Date == ymd('2007-02-01') |  Date == ymd('2007-02-02')) %>%
    na.omit


hpc <- hpc %>% mutate(DateTime = as.POSIXct(hpc$Date) + hpc$Time) 


################################################################################
# Draw the line graph in a PNG device

#« open the device, 480x480
png(filename = "plot2.png",
    width = 480,
    height = 480,
    units = "px")

# for the english date
oldloc <- Sys.getlocale("LC_TIME")


Sys.setlocale("LC_TIME", "English")
with(hpc, 
     plot(DateTime, 
          Global_active_power,
          type='l',
          col='black',
          xlab='',
          ylab='Global Active Power (kilowatts)')
)

dev.off()

# restore te locale
Sys.setlocale("LC_TIME", oldloc)
