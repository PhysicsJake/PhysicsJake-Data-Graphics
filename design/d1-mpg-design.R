library("tidyverse")
library("graphclassmate")


cars <- read_csv("data-raw/auto-mpg.csv")
cars <- rename(cars,"model_year" = "model year")
cars$model_year <- as.factor(cars$model_year)
cars$type=factor(ifelse(cars$model_year == 74 | cars$model_year == 80,"Year_After_Oil_Shock","Normal_Years"))
ggplot(cars, aes(y = mpg, x = model_year,group = model_year)) +
  geom_boxplot(width = 0.45, alpha = 0.9, outlier.shape = NA) +
  coord_flip() +
  #scale_y_continuous(trans = 'log10')+
  aes(fill = type) +
  scale_fill_manual(values = c(rcb("light_Grey"), rcb("light_Gn"))) +
  labs( x = "Model Year", y = "City Cycle MPG", title = "Oil Shock Era MPG" ) +
  guides(fill  = guide_legend(title = NULL), color = "none") +
  theme_graphclass()

ggsave(filename = "d1-mpg-figure.png",
       path    = "figures",
       width   = 8,
       height  = 2.5,
       units   = "in",
       dpi     = 300)
