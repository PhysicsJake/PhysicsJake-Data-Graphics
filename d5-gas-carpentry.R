library("tidyverse")
library("dplyr")
library("ggplot2")
library("graphclassmate")

gas<- read_csv("data-raw/gasdata.csv") 
glimpse(gas)

write_rds(gas,"data/gas-data.rds")
