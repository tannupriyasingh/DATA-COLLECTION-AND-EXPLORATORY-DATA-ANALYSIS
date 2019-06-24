library(ggplot2)

# Read the required data.
mort1 <- read.csv(file.choose())

# We make a custom column that will have the season and week.
mort1$S.W <- paste(mort1$SEASON, mort1$WEEK)


# We plot the data needed.
# We have the fixed plot as black line. 
# We then smoothen out the data so that it is a nice curved line. 
ggplot(mort1, aes(x=S.W, group = 1)) +
  geom_line(aes(y=PERCENT.P.I), colour = 'red') +
  geom_line(aes(y=THRESHOLD), colour = 'blue') +
  geom_line(aes(y=BASELINE), colour = 'blue') +
  geom_smooth(aes(y=BASELINE), method = lm, formula = y ~ splines::bs(x, 20), se = FALSE, colour = 'black') +
  geom_smooth(aes(y=THRESHOLD), method = lm, formula = y ~ splines::bs(x, 20), se = FALSE, colour = 'black') +
  scale_y_continuous(expand = c(0, 0), limits = c(4, 12), breaks=seq(4,12,2)) +
  scale_x_discrete(limits=mort1$S.W, breaks=mort1$S.W[c(T,F,F,F,F,F,F,F,F)]) +
  theme(plot.title = element_text(hjust = 0.5, face = 'bold'), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        plot.subtitle = element_text(hjust = 0.5)) +
  labs(fill = "ILI Activity Level",
       title = "Pneumonia And Influenza Mortality from 
       the National Center for Health Statistics Mortality Surveillance System", 
       subtitle = "Data through the week ending February 16, 2019, as of January 26, 2019",
       x = "MMWR Week",
       y = "% of all Deaths due to P&I") +
  annotate("text", x = '2015-16 50', y = 5, colour = "black", label="Seasonal Baseline") +
  annotate("text", x = '2015-16 50', y = 9, colour = "black", label="Epidemic Threshold") +
  annotate("segment", x = '2015-16 50',xend= '2015-16 3', y = 8.9, yend = 8.1, colour = " black", size=1, arrow=arrow()) +
  annotate("segment", x = '2015-16 50',xend= '2015-16 40', y = 5.2, yend = 6.1, colour = " black", size=1, arrow=arrow()) +
  theme(axis.text.x=element_text(angle=90),
        axis.line = element_line())

