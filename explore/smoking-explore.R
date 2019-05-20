library("tidyverse")
library("graphclassmate")
library("seplyr")
library("dplyr")
library("ggplot2")


smoking_cost <- read_csv("data-raw/smokingdata.csv")
smoking_deaths <- read_csv("data-raw/smokingdata2.csv")
pop <- read_csv("data-raw/2010pop.csv")
glimpse(smoking_cost)
glimpse(smoking_deaths)

cost <- filter(smoking_cost,Variable =="Total")

cost <- smoking_cost %>% 
  select(Year,LocationDesc,Data_Value) %>% 
  glimpse()

grouping_variables <- c("LocationDesc")

cost <- group_summarize(cost, grouping_variables, 
                        average_annual_cost = sum(Data_Value)/5) %>% 
                          glimpse()


deaths <- smoking_deaths %>% 
  select(Year,LocationDesc,Data_Value,Gender,MeasureDesc) %>% 
  glimpse()
deaths <- filter(deaths,MeasureDesc =="Average Annual SAM" & Gender == "Overall")
deaths <- deaths %>% 
  select(LocationDesc,Data_Value)

smoking <- merge(deaths, cost, "LocationDesc")
smoking <- merge(smoking, pop, "LocationDesc")
smoking <- rename(smoking, "average_annual_deaths"="Data_Value")
smoking <- mutate(smoking, death_rate = average_annual_deaths/population)


#r functions go inside the summarize to give you the next step.
# Give the flexibility to not go section by section and peruse through.
# knowing the funcitons and how they manage the data is going to be an advantageous thing to learn 

ggplot(data = smoking, aes(x = average_annual_cost, y = average_annual_deaths)) +
  geom_point(color = rcb("light_BG"))+
  geom_jitter(width = 0.1, height = 0.2, shape = 21, size = 2, alpha = 0.7) +
  theme_graphclass(line_color = rcb("mid_Gray"), 
                 font_size = 12) + 
  scale_color_grey(start=0.7, end=0.2)

ggsave(filename = "d3-smoking-figure.png",
       path    = "figures",
       width   = 8,
       height  = 5.3,
       units   = "in",
       dpi     = 300)



