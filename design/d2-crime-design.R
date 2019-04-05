# Jake Spears
# 4/4/2019

# packages
library("tidyverse")
library("dplyr")
library("ggplot2")
library("graphclassmate")


crime <- read_rds("data/crime-data.rds")

ggplot(data = crime, aes(x = arrests/1000, y = Race)) + 
  geom_point() +
  facet_wrap(vars(Area), ncol = 6, as.table = FALSE) +
  theme_graphclass()

ggsave(filename = "d2-crime-data.png",
       path    = "figures",
       width   = 8,
       height  = 10,
       units   = "in",
       dpi     = 300)
