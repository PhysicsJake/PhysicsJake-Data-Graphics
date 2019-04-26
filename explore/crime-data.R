# Jake Spears
# 4/4/2019

# packages
library("tidyverse")
library("dplyr")
library("ggplot2")
library("graphclassmate")


crime<- read_csv("data-raw/Crime_Data_from_2010_to_Present.csv") 
crime <- crime %>% 
  as_tibble() %>% 
  glimpse()

crime<-select(crime,'Area ID','Victim Descent','Area Name')
crime$`Area ID` <- as.numeric(crime$`Area ID`)
crime <- crime[complete.cases(crime), ]

colnames(crime)[3] <- "Area"
colnames(crime)[2] <- "Race"

hold <- crime %>% group_by(Area,Race) %>% mutate(arrests = n())
hold <- ungroup(hold)
crime <- unique(hold)

crime$Race <- as.factor(crime$Race)
crime$Area <- as.factor(crime$Area)

newlevels <- c("Asian Indian", "Unknown", "White","Vietnamese","Hawaiian", "Samoan","Pacific Islander","Other","Laotian","Korean","Japanese","American Indian","Hispanic","Guamanian","Filipino","Cambodian","Chinese","Black","General Asian","Undisclosed")
levels(crime$Race) <- rev(newlevels)

crime <- crime %>%
  mutate(Race = fct_reorder(Race, arrests)) %>% 
  mutate(Area = fct_reorder(Area, arrests))

ggplot(data = crime, aes(x = arrests/1000, y = Race)) + 
  geom_point() +
  facet_wrap(vars(Area), ncol = 6, as.table = FALSE) +
  theme_graphclass()

write_rds(crime,"data/crime-data.rds")

library("VIM")
aggr(crime, 
     # color: observed, missing, imputed
     col = c(rcb("pale_BG"), rcb("mid_BG")), 
     numbers  = TRUE, 
     bars     = TRUE, 
     sortVars = TRUE, 
     prop     = TRUE, 
     combine  = TRUE
)
