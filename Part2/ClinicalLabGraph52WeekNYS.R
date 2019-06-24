#Clinical Labs for 52 weeks od data
influenzaPositive <- read.csv(file.choose(), skip = 1)
par(bg = "white")
# Plotting box plot for Infuenza A data against Number of positive specimens
barPlotVar <-
  barplot(
    height = influenzaPositive$TOTAL.A,
    ylab = "Number of Positive Specimens",
    xlab = "Weeks",
    col = "yellow",
    ylim = c(0, max(influenzaPositive$TOTAL.A)),
    main="NYS Influenza Positive Tests Reported to CDC by U.S. Clinical Laboratories, National Summary, 2018-19 Season"
  )
par(new = T)
# we are plotting box plot for Infuenza B data against Number of positive specimens
barPlotVar2 <-
  barplot(
    height = influenzaPositive$TOTAL.B,
    ylab = "Number of Positive Specimens",
    xlab = "Weeks",
    col = "green",
    ylim = c(0, max(influenzaPositive$TOTAL.A)),
    axes = FALSE
  )
#Pasting two columns Year and week to display as Xlabel
xaxisLabel = paste(influenzaPositive$YEAR, influenzaPositive$WEEK, sep = "-")
# Plotting X Axis
axis(1, at = barPlotVar, labels = xaxisLabel, las = 2,  cex.axis=0.7, tck=-.01)
par(new = T)
# Plotting Line plot for percent of positive tested influenza against Number of positive specimens
linePlot <-
  plot(
    influenzaPositive$PERCENT.POSITIVE,
    col = "black",
    type = "l",
    ylim = c(0, 40),
    xlab = "",
    ylab = "" ,
    axes = FALSE
  )
# Plotting Line plot for percent of positive tested for FLU A against Number of positive specimens
lines(
  influenzaPositive$PERCENT.A,
  col = "pink",
  lty = "dashed",
  ylim = c(0, 40),
  type = "l"
)
# Plotting Line plot for percent of positive tested for FLU B against Number of positive specimens
lines(
  influenzaPositive$PERCENT.B,
  col = "dark green",
  lty = "dashed",
  ylim = c(0, 15000),
  type = "l"
)
# Plotting Right Y Axis
axis(4,
     at = linePlot,
     ylab = "Percent Positive",
     ylim = c(0, max(influenzaPositive$PERCENT.POSITIVE)))
legend(
  "topright",
  inset = c(.1, 0),
  c("A", "B", "Percent Positive", "% Positive Flu A", "% Positive Flu B"),
  col = c("yellow", "green", "black", "pink", "green"),
  pch = c(15, 15, NA, NA, NA),
  lty = c(0, 0, 1, 2, 2),
  bty = "n"
)

