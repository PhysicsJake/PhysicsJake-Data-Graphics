library("tidyverse")
library("dplyr")
library("ggplot2")
library("graphclassmate")
library("magick")

mortality<- read_csv("data-raw/NCHS_-_Death_rates_and_life_expectancy_at_birth.csv") 
glimpse(mortality)

mortality <- mortality %>% 
  rename(
    Life_Expectancy = "Average Life Expectancy (Years)",
  ) %>%
  glimpse()

mortality <- as_tibble(mortality)
mortality <- filter(mortality,Sex == "Both Sexes")


hospice_graph <- ggplot(mortality, aes(x = Year, y = Life_Expectancy, color = Race)) +
  geom_jitter() +
  geom_point() +
  theme_graphclass(line_color = rcb("mid_Gray"), 
                   font_size = 12) + 
  scale_color_grey(start=0.7, end=0.2)
  theme(axis.line = element_line(colour = rcb("pale_Gray")), 
        strip.text = element_text(color = rcb("dark_Gray"), face = "bold"), 
        plot.margin = unit(c(2, 4, 1, 0), "mm"), # top, right, bottom, and left margins
        panel.border = element_rect(color = rcb("pale_Gray"), fill = NA), 
        panel.spacing = unit(3, "mm"), 
        plot.background = element_rect(color = NA, fill = rcb("pale_Gray")), 
        panel.background = element_rect(color = NA, fill = rcb("pale_Gray")), 
        panel.grid.minor = element_blank(), 
        strip.background = element_rect(color = rcb("pale_Gray"), fill = rcb("pale_Gray"))
  )

image_file <- "resources/hospice.jpg"
image_url  <- "https://www.lakecountyhospice.org/wp-content/uploads/2014/02/Dying-at-Home-600x399.jpg"

if(!file.exists(image_file)) {
  hospice <- image_read(image_url)  
  image_write(hospice, path = image_file, format = "jpg")
}
hospice <- image_read("resources/hospice.png")
hospice <- image_quantize(hospice,  max = 10, colorspace = "gray")
hospice  <- image_colorize(hospice,  opacity = 25, color = "white")

ggsave(plot = hospice_graph, 
       filename = "hospiceg.png",
       path    = "figures",
       width   = 4,
       height  = 4,
       dpi = 300
)
hospice <- image_scale(hospice, "x500")
hospice_graph <- image_read("explore/test_hospice_figure.jpg")
hospice_graph <- image_scale(hospice_graph, "x500")
