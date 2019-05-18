# Jake Spears
# 5/10/2019

# load packages
library("micromap")

s

data("USstates")
data("edPov")
head(edPov)
head(USstates)
statePolys <- create_map_table(USstates, IDcolumn="ST")
head(statePolys)







mmplot(stat.data=edPov, map.data=statePolys,
         + panel.types=c("labels", "dot", "dot","map"),
         + panel.data=list("state","pov","ed", NA),
         + ord.by="pov", grouping=5,
         + median.row=T,
         + map.link=c("StateAb","ID"),
         + plot.height=9,
         + colors=c("red","orange","green","blue","purple"),
         + panel.att=list(list(1, header="States",
         + panel.width=.8,
         + align="left", text.size=.9),
         + list(2, header="Percent Living Below \n Poverty Level",
         + graph.bgcolor="lightgray", point.size=1.5,
         + xaxis.ticks=list(10,15,20), xaxis.labels=list(10,15,20),
         + xaxis.title="Percent"),
         + list(3, header="Percent Adults With\n4+ Years of College",
         + graph.bgcolor="lightgray", point.size=1.5,
         + xaxis.ticks=list(20,30,40), xaxis.labels=list(20,30,40),
         + xaxis.title="Percent"),
         + list(4, header="Light Gray Means\nHighlighted Above",
         + inactive.fill="lightgray",
         + inactive.border.color=gray(.7), inactive.border.size=2,
         + panel.width=.8)), print.file="fig2.jpeg",
         + print.res=300)

