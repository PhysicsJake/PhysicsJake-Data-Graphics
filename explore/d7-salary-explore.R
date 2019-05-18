# Jake Spears
# 5/10/2019

# load packages
library("micromap")
library("tidyverse")

salary<- read_rds("data/d7-salary-data.rds")
salary <- as.data.frame(salary)
glimpse(salary)

data("USstates")
data("edPov")
head(edPov)
head(USstates@data)
statePolys <- create_map_table(USstates, IDcolumn="ST")
head(statePolys)

mmplot(stat.data   = salary, 
       map.data    = statePolys, 
       panel.types = c("labels", "dot","dot", "map"),
       panel.data  = list("area", "h_mean", "adjusted_mean_salary", NA), 
       ord.by      = "adjusted_mean_salary", 
       grouping    = 5,
       median.row  = TRUE, 
       map.link    = c("area_title", "ID"), 
       print.file  = "fig1.jpeg", 
       print.res = 300)












