# Jake Spears
# 5/10/2019

# load packages
library("tidyverse")
library("dplyr")
library("ggplot2")
library("graphclassmate")
library("GGally")
library("scagnostics")

printing<- read_rds("data/d6-3dprinting-data.rds") 
glimpse(printing)

ggparcoord(printing, columns = c(1,2,5,8,11,12))
my_color <- c(rcb("dark_BG"),  rcb("dark_Br"))
my_fill  <- c(rcb("light_BG"), rcb("light_Br"))
my_title <- "Comparing Effects of 3D Printing Variables on Tensile Strength"
ggparcoord(data = printing, columns = c(1,2,4,5,10,11,12), groupColumn  = "material",
           scale        = "std", 
           # scaleSummary = "median", # use with  scale == “center”
           # centerObsID  = 1,        # use with scale == “centerObs”
           missing      = "exclude", 
           order        = "Clumpy", # scagnostic measures 
           alphaLines   = 0.8, 
           mapping      = NULL, 
           title        = my_title) +
  labs(x = "", y = "")

pm <- ggscatmat(printing, columns = c(1,3,4,5,10,11,12))

pm <- ggpairs(printing, columns = c(1,2,4,5,10,11,12),  
              mapping = ggplot2::aes(color = material, fill = material), 
              title   = my_title, 
              legend  = 1, 
              upper   = list(continuous = wrap("cor", size = 2.5))) +
  theme(legend.position = "right",
        panel.spacing = unit(1, "mm"),  
        axis.text.x = element_text(angle = 90, hjust = 1))

# loop through each panel to edit colors
for(i in 1:pm$nrow) {
  for(j in 1:pm$ncol){
    pm[i, j] <- pm[i, j] + 
      scale_fill_manual(values  = my_fill) +
      scale_color_manual(values = my_color)
  }}
