library("tidyverse")
library("graphclassmate")


osu_sal <- read_rds("data/osu_sal.rds")
ggplot(osu_sal, aes(y = ANNUAL_BASE_SALARY, x = POSITION_GROUP)) +
  geom_point() +
  coord_flip() +
  aes(color = POSITION_GROUP) +
  scale_color_manual(values = c(rcb("dark_BG"), rcb("dark_PG"), rcb("dark_G"))) +
  aes(fill = POSITION_GROUP) +
  scale_fill_manual(values = c(rcb("light_BG"), rcb("light_PG"), rcb("light_G"))) +
  labs( x = "Department", y = "", title = "Annnual Base Salary ($)" ) +
  guides(fill  = guide_legend(title = NULL), color = "none") +
  theme_graphclass()


