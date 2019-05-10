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
ggsave(filename = "d6-3dprinting-figure.png",
       path    = "figures",
       width   = 8,
       height  = 8,
       units   = "in",
       dpi     = 300)
