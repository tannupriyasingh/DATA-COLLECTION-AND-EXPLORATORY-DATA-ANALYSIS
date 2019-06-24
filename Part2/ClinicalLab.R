#PROBLEM1
influenzaPositive <- read.csv(file.choose(), skip = 1)
par(bg = "white")
# Plotting box plot for Infuenza A data against Number of positive specimens
barPlotVar <-
  barplot(
    height = influenzaPositive$TOTAL.A,
    ylab = "Number of Positive Specimens",
    xlab = "Weeks",
    col = "yellow",
    ylim = c(0, 14000),
    main="Influenza Positive Tests Reported to CDC by U.S. Clinical Laboratories, National Summary, 2018-19 Season"
  )
par(new = T)
# we are plotting box plot for Infuenza B data against Number of positive specimens
barPlotVar2 <-
  barplot(
    height = influenzaPositive$TOTAL.B,
    ylab = "Number of Positive Specimens",
    xlab = "Weeks",
    col = "green",
    ylim = c(0, 14000),
    axes = FALSE
  )
#Pasting two columns Year and week to display as Xlabel
xaxisLabel = paste(influenzaPositive$YEAR, influenzaPositive$WEEK, sep="-")
par(new = T)
# Plotting Line plot for percent of positive tested influenza against Number of positive specimens
linePlot <-
  plot(
    influenzaPositive$PERCENT.POSITIVE,
    col = "black",
    type = "l",
    ylim = c(0, 35),
    xlab = "",
    ylab = "" ,
    axes = FALSE
  )
# Plotting Line plot for percent of positive tested for FLU A against Number of positive specimens
lines(
  influenzaPositive$PERCENT.A,
  col = "pink",
  lty = "dashed",
  ylim = c(0, 30),
  type = "l"
)
# Plotting Line plot for percent of positive tested for FLU B against Number of positive specimens
lines(
  influenzaPositive$PERCENT.B,
  col = "dark green",
  lty = "dashed",
  ylim = c(0, 30),
  type = "l"
)
# Plotting X Axis
axis(1, at = barPlotVar, labels = xaxisLabel, las = 2, cex.axis=0.7, tck=-.01)
# Plotting Right Y Axis
axis(4,
     at = linePlot,
     ylab = "Percent Positive",
     ylim = c(0, 35), hadj = TRUE, las = 2, cex.axis=0.7, tck=-.01)
legend(
  "topleft",
  inset = c(.1, 0),
  c("A", "B", "Percent Positive", "% Positive Flu A", "% Positive Flu B"),
  col = c("yellow", "green", "black", "pink", "green"),
  pch = c(15, 15, NA, NA, NA),
  lty = c(0, 0, 1, 2, 2),
  bty = "n"
)

