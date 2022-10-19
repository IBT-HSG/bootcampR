# Packages -----
# no matter where you call the functions & packages, always load them in the 
# first few lines

# install.packages('tidyverse')
library(tidyverse)


# Constants -----
# this is the place where you assign constants, e.g.:
VAT <- 0.077 # Swiss VAT (7.7%)


# Working Directory -----
getwd() # identify your current directory
setwd() # adjust it if needed


# Read Data -----
# ideally, you have a folder called 'data' that contains two subfolders:
# 'raw' from where you read the original data &
# 'processed' where you store the data after you have transformed it
raw <- read.csv(file = 'data/raw/mtcars.csv',
                sep  = ',')


# Data Exploration -----

# Transform Data -----

# do something with the data
processed <- raw


# Save Data -----
# There are different formats you can use. CSV is the most compatible format
write.csv(x = processed,
          file = 'data/processed/transformed_data.csv')
save(processed, 
     file = 'transformed_data.rda')



# Data Analyses -----

