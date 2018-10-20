################################################################################
## Coursera :       Johns Hopkins
## Specialization : Data Science 
## Course #04 :     Exploratory Data Analysis
################################################################################
## Week 1 - Programming Assignment #1
## GitHub : Chris-FR-GitHib
################################################################################
#
#                         test_load_by_chunk.R
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
# reading the data ==>  read_delim_chunked
# using the readr package 'tibble output)

# Only the 2 dates
#??? the call back will subset files at the end of every chunk
f <- function(x, pos) subset(x, Date == ymd('2007-02-01') |  Date == ymd('2007-02-02'))

hpc <- read_delim_chunked('household_power_consumption.txt',
                          DataFrameCallback$new(f), 
                          chunk_size = 250000,
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


hpc <- hpc %>% mutate(DateTime = as.POSIXct(hpc$Date) + hpc$Time) 

# check the size
dim(hpc)

################################################################################
# Simple screen plot to test
Sys.setlocale("LC_TIME", "English")
with(hpc, 
     plot(DateTime, 
          Global_active_power,
          type='l',
          col='blue',
          xlab='',
          ylab='Global Active Power (kilowatts)')
)

# restore te locale
Sys.setlocale("LC_TIME", oldloc)
