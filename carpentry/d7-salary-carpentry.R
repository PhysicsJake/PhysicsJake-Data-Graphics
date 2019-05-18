library("tidyverse")
library("dplyr")
library("ggplot2")
library("graphclassmate")
library("GGally")

salary<- read_csv("data-raw/salarydata.csv") 
glimpse(salary)
salary<- select(salary,"area","area_title","adjusted_mean_salary","h_mean")
glimpse(salary)
write_rds(salary,"data/d7-salary-data.rds")



