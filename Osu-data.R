# Jake Spears
# 3/15/2019

# packages
library("tidyverse")

osu <- read_csv("data-raw/osu-data.csv") 
osu<-select(osu,FTE,ANNUAL_BASE_SALARY,POSITION_GROUP)
library(dplyr)
osu <- drop_na(osu)
osu <- filter(osu,FTE == 1)
health <- filter(osu,POSITION_GROUP == "Health System")
athletics <- filter(osu,POSITION_GROUP == "Athletics")
university <- filter(osu,POSITION_GROUP == "University")
write_rds(osu, "data/osu_sal.rds")
write_rds(athletics, "data/athletics_sal.rds")
write_rds(health, "data/health_sal.rds")
write_rds(university, "data/university_sal.rds")