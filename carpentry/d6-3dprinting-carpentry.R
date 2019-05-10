library("tidyverse")
library("dplyr")
library("ggplot2")
library("graphclassmate")
library("GGally")

printing<- read_csv("data-raw/data.csv") 
glimpse(printing)

write_rds(printing,"data/d6-3dprinting-data.rds")




