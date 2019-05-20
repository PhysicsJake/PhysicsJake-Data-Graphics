# Jake Spears
# 5/10/2019

# load packages
library("micromap")
library("tidyverse")
library("graphclassmate")

salary<- read_rds("data/d7-salary-data.rds")
salary <- as.data.frame(salary)
salary <- mutate(salary,adjusted_mean_salary = adjusted_mean_salary/1000 )
salary <- mutate(salary,h_mean = h_mean/1000 )
glimpse(salary)

data("USstates")
data("edPov")
head(edPov)
head(USstates@data)
statePolys <- create_map_table(USstates, IDcolumn="ST")
head(statePolys)
list(1, align="left")
list(2, graph.bgcolor="lightgray")
list(3, graph.bgcolor="lightgray")
list(list(1, align="left"), list(2, graph.bgcolor="lightgray"),list(3, graph.bgcolor="lightgray"))



mmplot(stat.data      = salary, 
       map.data       = statePolys, 
       panel.types    = c("map", "dot_legend","labels", "dot","dot"),
       panel.data     = list(NA,NA,"area", "adjusted_mean_salary", "h_mean", NA), 
       ord.by         = "adjusted_mean_salary", 
       rev.ord        = TRUE,
       grouping       = 5,
       median.row     = TRUE, 
       map.link       = c("area_title", "ID"), 
       plot.height    = 9,
       colors         = c(rcb("light_PR"),rcb("dark_PR"),rcb("dark_Gn"),rcb("light_BG"),rcb("light_Gn")),
        panel.att=list(list(2, point.type=20,panel.width =1.5,
                              point.border=TRUE),
                         list(3, header="States", panel.width=1.1,
                                align="left", text.size=.9),
                         list(4, header="RPP Adjusted\nAverage Salary",
                               graph.bgcolor="lightgray", point.size=1,
                                panel.width=1.5,xaxis.title="USD (Thousands)"),
                         list(5, header="Average Salary",
                                graph.bgcolor="lightgray", point.size=1,
                                panel.width=1.5,xaxis.title="USD (Thousands)"),
                         list(1, header="Light Gray Means\nHighlighted Above",
                                inactive.fill="lightgray",
                                inactive.border.color=gray(.7), inactive.border.size=2,
                                panel.width=1.3)),
        print.file="figures/d7-salary.png",print.res=300)
                              












