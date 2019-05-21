library("tidyverse")
library("dplyr")
library("ggplot2")
library("graphclassmate")
library("magick")

gas<- read_rds("data/gas-data.rds") 
molefrac <- read_csv("data/molefrac.csv")
glimpse(gas)
glimpse(molefrac)

x <- ggplot(gas, aes(x = Year, y = CO2_per_equivalent_oil)) + 
  geom_line() + 
  geom_point() 



ggsave(plot = x,
       filename = "d5-gas.png",
            path    = "figures",
            width   = 8,
            height  = 5.3,
            units   = "in",
            dpi     = 300)

p <- ggplot(molefrac, aes(x = year, y = mole_fraction_CO2)) + 
  geom_line() + 
  geom_point() 

ggsave(plot = p,
       filename = "d5-gas1.png",
            path    = "figures",
            width   = 8,
            height  = 5.3,
            units   = "in",
            dpi     = 300)

p <- image_read("figures/d5-gas.png")
x <- image_read("figures/d5-gas1.png")

final_img <- image_append(c(p, x), stack = FALSE)

image_write(final_img, 
            path = "figures/d5-gas-final.png", 
            format = "png")
