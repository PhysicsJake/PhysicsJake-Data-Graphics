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
mortality <- filter(mortality, Race == "White" | Race == "Black")


p<-ggplot(mortality, aes(x = Year, y = Life_Expectancy, color = Race)) +
  geom_jitter() +
  geom_point() + 
  facet_wrap( ~Sex)  +
  geom_rect(aes(xmin=1971, xmax=1971, ymin=0, ymax=Inf)) +
  geom_rect(aes(xmin=1900, xmax=2016, ymin=70, ymax=70)) +
annotate("rect",xmin=1980, xmax=1997, ymin=0, ymax=Inf, alpha = 0.2) +
  theme_graphclass(line_color = rcb("mid_Gray"), 
                   font_size = 12) + 
  scale_color_grey(start=0.2, end=0.6) +
  geom_text(aes(label=ifelse(Year == 2014,as.character(Race),'')),hjust=.6,vjust=-.5) +
  theme(axis.line = element_line(colour = rcb("pale_Gray")), 
        strip.text = element_text(color = rcb("dark_Gray"), face = "bold"), 
        plot.margin = unit(c(2, 4, 1, 0), "mm"), # top, right, bottom, and left margins
        panel.border = element_rect(color = rcb("pale_Gray"), fill = NA), 
        panel.spacing = unit(3, "mm"),
        plot.background = element_rect(color = NA, fill = rcb("pale_Gray")), 
        panel.background = element_rect(color = NA, fill = rcb("pale_Gray")), 
        panel.grid.minor = element_blank(), 
        strip.background = element_rect(color = rcb("pale_Gray")),
        legend.position = "none" 
      )
ggsave(plot = p, 
               filename = "d4-mortality-figure.png",
               path    = "figures",
               width   = 8,
               height  = 8,
               dpi = 300)
  
image_file <- "resources/grave.jpg"
image_url  <- "https://i.dailymail.co.uk/i/pix/2015/05/25/21/2911A8EE00000578-3096297-Peter_Warigi_40_of_Kenya_visits_the_grave_of_his_brother_SSGT_An-a-53_1432586442011.jpg"

if(!file.exists(image_file)) {
  grave <- image_read(image_url)  
  image_write(hospice, path = image_file, format = "jpg")
}
grave <- image_read("resources/grave.jpg")
grave <- image_quantize(grave,  max = 10, colorspace = "gray")
# adjust brightness and contrast
grave <- image_modulate(grave, brightness = 200)
grave <- image_contrast(grave, sharpen = 0)
grave <- image_colorize(grave, opacity = 25, color = "white")
grave <- image_scale(grave, "500")



p <- image_read("figures/d4-mortality-figure.png")
p <- image_scale(p, "500")
p <- image_border(p, rcb("pale_Gray"), "15x15")
grave <- image_border(grave, rcb("pale_Gray"), "15x15")


final_img <- image_append(c(grave, p), stack = TRUE)

image_write(final_img, 
            path = "figures/d4-mortality-final.png", 
            format = "png")
