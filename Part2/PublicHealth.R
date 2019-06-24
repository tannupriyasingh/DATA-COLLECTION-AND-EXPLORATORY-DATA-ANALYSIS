library(ggplot2)
graph2 <- read.csv(file.choose(), skip = 1)
colnames(graph2)
graph2Week <- paste(graph2$YEAR, graph2$WEEK, sep = "-")
#Plotting Column values
values <- c(
  graph2$A..Subtyping.not.Performed.,
  graph2$A..2009.H1N1.,
  graph2$A..H3.,
  graph2$H3N2v,
  graph2$B,
  graph2$BVic,
  graph2$BYam
)
#stacking the columns in lexicalgraphic format
type <-
  c(
    rep("1A..Subtyping.not.Performed.", 17),
    rep("2A..2009.H1N1.", 17),
    rep("3A..H3.", 17),
    rep("4H3N2v", 17),
    rep("5B", 17),
    rep("6BVic", 17),
    rep("7BYam", 17)
  )
#Combining data in a frame
mydata <- data.frame(graph2Week, values)
head(mydata)
#Plotting the dataframe
p <- ggplot(mydata, aes(factor(mydata$graph2Week), values)) +
  scale_fill_manual(
    values = c(
      "yellow",
      "orange",
      "red",
      "purple",
      "darkgreen",
      "lawngreen",
      "green4"
    ),
    name = "",
    labels = c(
      "A(subtyping not performed)",
      "A(H1N1)pdm09",
      "A(H3N2)",
      "H3N2v",
      "B (lineage not performed)",
      "B (Victoria Linage)",
      "B(Yamagata Lineage)"
    )
  )
p + geom_bar(stat = "identity", aes(fill = type)) + labs(title = "Influenza Positive Tests Reported to CDC by Public Health Laboratories, National Summary, 2018-19 Season",  y = "Number of Positive Specimens", x = "Week") +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.background = element_blank(),
    plot.title = element_text(hjust = 0.5),
    axis.line = element_line(colour = "black"),
    axis.text.x = element_text(angle = 60, hjust = 1)
  )

