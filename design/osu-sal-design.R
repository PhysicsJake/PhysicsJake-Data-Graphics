library("tidyverse")
library("graphclassmate")


osu_sal <- read_rds("data/osu_sal.rds")
outlier_only <- osu_sal %>%
  group_by(POSITION_GROUP) %>%
  mutate(outlier = ANNUAL_BASE_SALARY > median(ANNUAL_BASE_SALARY) + 4.5 * IQR(ANNUAL_BASE_SALARY)) %>%
  ungroup() %>%
  filter(outlier == TRUE)
ggplot(osu_sal, aes(y = ANNUAL_BASE_SALARY, x = POSITION_GROUP)) +
  geom_boxplot(width = 0.45, alpha = 0.9, outlier.shape = NA) +
  coord_flip() +
  scale_y_continuous(trans = 'log10')+
  aes(color = POSITION_GROUP) +
  scale_color_manual(values = c(rcb("dark_BG"), rcb("dark_PG"), rcb("dark_G"))) +
  aes(fill = POSITION_GROUP) +
  scale_fill_manual(values = c(rcb("light_BG"), rcb("light_PG"), rcb("light_G"))) +
  labs( x = "Department", y = "", title = "Annnual Base Salary ($)" ) +
  guides(fill  = guide_legend(title = NULL), color = "none") +
  geom_jitter(data = outlier_only, width = 0.05, height = 0.2, alpha = 0.25, shape = 21) +
  theme_graphclass()

ggsave(filename = "osu-data-fig.png",
       path    = "figures",
       width   = 8,
       height  = 2.5,
       units   = "in",
       dpi     = 300)
