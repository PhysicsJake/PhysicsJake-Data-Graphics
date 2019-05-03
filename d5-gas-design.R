library("tidyverse")
library("dplyr")
library("ggplot2")
library("graphclassmate")

gas<- read_rds("data/gas-data.rds") 
glimpse(gas)

ggplot(gas, aes(x = Year, y = CO2_per_equivalent_oil)) + 
  geom_line() + 
  geom_point() 

ggsave(filename = "d5-gas.png",
       path    = "figures",
       width   = 8,
       height  = 5.3,
       units   = "in",
       dpi     = 300)