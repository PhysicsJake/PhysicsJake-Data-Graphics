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
  geom_point()+
  geom_jitter(width = 0.1, height = 0.2, shape = 21, size = 2, alpha = 0.7) +
  theme_graphclass(line_color = rcb("mid_Gray"), 
                   font_size = 12) + 
  scale_color_grey(start=0.2, end=0.6) +
  theme(axis.line = element_line(colour = rcb("pale_Gray")), 
        strip.text = element_text(color = rcb("dark_Gray"), face = "bold"), 
        plot.margin = unit(c(2, 4, 1, 0), "mm"), # top, right, bottom, and left margins
        panel.border = element_rect(color = rcb("pale_Gray"), fill = NA), 
        panel.spacing = unit(3, "mm"),
        plot.background = element_rect(color = NA, fill = rcb("pale_Gray")), 
        panel.background = element_rect(color = NA, fill = rcb("pale_Gray")), 
        panel.grid.minor = element_blank(), 
        strip.background = element_rect(color = rcb("pale_Gray")),
        legend.position = "none" )

ggsave(filename = "d3-smoking-figure.png",
       path    = "figures",
       width   = 8,
       height  = 5.3,
       units   = "in",
       dpi     = 300)



image_file <- "resources/smoking-ref.jpg"
image_url  <- "https://www.thoughtco.com/thmb/5wnmaVlG99CPPXgE8QpUwRcFYL0=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-78777652-5697ccac5f9b58eba49e7567.jpg"


if(!file.exists(image_file)) {
  hospice <- image_read(image_url)  
  image_write(hospice, path = image_file, format = "jpg")
}
hospice <- image_read("resources/smoking-ref.jpg")
hospice <- image_quantize(hospice,  max = 10, colorspace = "gray")
hospice  <- image_colorize(hospice,  opacity = 25, color = "white")
# adjust brightness and contrast
hopsice <- image_modulate(hospice, brightness = 200)
hospice <- image_contrast(hospice, sharpen = 0)
hospice <- image_colorize(hospice, opacity = 25, color = "white")
hospice <- image_scale(hospice, "x300")



p <- image_read("figures/d3-smoking-figure.png")
p <- image_scale(p, "x300")
p <- image_border(p, rcb("pale_Gray"), "15x15")
hospice <- image_border(hospice, rcb("pale_Gray"), "15x15")


# append to the graph image 
final_img <- image_append(c(hospice, p), stack = FALSE)

image_write(final_img, 
            path = "figures/d3-smoking-final.png", 
            format = "png")

