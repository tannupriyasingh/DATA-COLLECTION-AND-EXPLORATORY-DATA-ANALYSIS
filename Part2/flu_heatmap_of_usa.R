# Install all the packages as needed for this graph
# if you do not have devtools installed on your machine
# please un-comment and install it below.
install.packages("devtools", dependencies = TRUE)
install.packages("ggplot2")
devtools::install_github("wmurphyrd/fiftystater")

# The required libraries to get the right graph
library(ggplot2)
library(fiftystater)

# Read the heatmap data file from Week 40 of 2018 to Week 4 of 2019
allData <- read.csv(file.choose())
# Take out a subset for week 4
week4data <- subset(allData, allData$WEEK == 4)
# Seperate the states from the maps package

# Make the required by taking the week 4 data and then 
# plot the Activity Level as required.
ggplot(week4data, aes(map_id = tolower(week4data$STATENAME))) + 
  coord_map() +
  geom_map(map = fifty_states, aes(fill = ACTIVITY.LEVEL)) +
  expand_limits(x = fifty_states$long, y= fifty_states$lat) +
  ggtitle("2018-19 Influenza Season Week 4 ending Jan 26, 2019") +
  theme(plot.title = element_text(hjust = 0.5, face = 'bold')) +
  labs(fill = "ILI Activity Level") +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        panel.background=element_blank()) +
  scale_fill_manual(values=c( "#00C201",  "#5CF700", "#8BF701", "#BAF700", "#DFF500", 
                              "#F7DF00", "#FCB100", "#FC8300", "#FA4E01", "#cb0000"))
