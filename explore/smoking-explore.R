library("tidyverse")
library("graphclassmate")
library("seplyr")


smoking_cost <- read_csv("data-raw/smokingdata.csv")
smoking_deaths <- read_csv("data-raw/smokingdata2.csv")
glimpse(smoking_cost)
glimpse(smoking_deaths)

cost <- smoking_cost %>% 
  select(Year,LocationDesc,Data_Value) %>% 
  glimpse()

grouping_variables <- c("LocationDesc")

cost <- group_summarize(cost, grouping_variables, 
                        total = sum(Data_Value)) %>% 
                          glimpse()
#r functions go inside the summarize to give you the next step.
# Give the flexibility to not go section by section and peruse through.
# knowing the funcitons and how they manage the data is going to be an advantageous thing to learn 



