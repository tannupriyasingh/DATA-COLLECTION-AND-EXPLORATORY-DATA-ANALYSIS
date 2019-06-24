library(ggplot2)

# We read the file that contains the required data.
pediatrics_data <- read.csv(file.choose())

# For each season we split the data according to the season
# We will later use this data to show the sum of each season.
deaths_15_16 <- pediatrics_data[ which(pediatrics_data$SEASON=='2015-16'),]
deaths_15_16_sum <- sum(deaths_15_16$NO..OF.DEATHS)
deaths_16_17 <- pediatrics_data[ which(pediatrics_data$SEASON=='2016-17'),]
deaths_16_17_sum <- sum(deaths_16_17$NO..OF.DEATHS)
deaths_17_18 <- pediatrics_data[ which(pediatrics_data$SEASON=='2017-18'),]
deaths_17_18_sum <- sum(deaths_17_18$NO..OF.DEATHS)
deaths_18_19 <- pediatrics_data[ which(pediatrics_data$SEASON=='2018-19'),]
deaths_18_19_sum <- sum(deaths_18_19$NO..OF.DEATHS)

# We plot the data for the overall all seasons. 
# We will then also add small boxes that will show the 
# sum of reported pediatric deaths per season.
ggplot(pediatrics_data, aes(x=pediatrics_data$WEEK.NUMBER)) + 
  geom_col(aes(y=pediatrics_data$CURRENT.WEEK.DEATHS, fill = "dark green"), colour= "black") +
  geom_col(aes(y=pediatrics_data$PREVIOUS.WEEK.DEATHS, fill = "cyan"), colour= "black") +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 30), breaks=seq(0,30,5)) +
  scale_x_discrete(breaks = pediatrics_data$WEEK.NUMBER[c(T,F,F,F,F,F)]) +
  scale_fill_manual(labels = c("Deaths Reported Previous Week", "Deaths Reported Current Week"), values = c("dark green", "cyan")) +
  theme(axis.text.x=element_text(angle=90),
        panel.background=element_blank(),
        axis.line = element_line(),
        plot.title = element_text(hjust = 0.5, face = 'bold'),
        plot.subtitle = element_text(hjust = 0.5),
        legend.position="bottom",
        legend.background = element_rect(colour="black", size=.5, linetype="solid")) +
  labs(fill= NULL, 
       title = "Number of Influenza-Associated Pediatric Deaths \n by Week of Death: 2015-2016 season to Week 4 of 2019", 
       x = "Week of Death",
       y = "Number of Deaths") +
  annotate("text", x = '2016-08', y = 25, colour="black", label=paste("2015-2016 \n Number of Deaths \n Reported =", deaths_15_16_sum)) +
  annotate("text", x = '2017-02', y = 25, colour="black", label=paste("2016-2017 \n Number of Deaths \n Reported =", deaths_16_17_sum)) +
  annotate("text", x = '2017-48', y = 25, colour="black", label=paste("2017-2018 \n Number of Deaths \n Reported =", deaths_17_18_sum)) +
  annotate("text", x = '2018-40', y = 25, colour="black", label=paste("2018-2019 \n Number of Deaths \n Reported =", deaths_18_19_sum))

