library(ggmap)
library(fiftystater)
library(ggplot2)

###### Get Clean Tweets ######

## Load the tweets from flu_clean.csv
clean_tweets <- read.csv(file.choose())

###### "Flu" Keyword Tweets/State ######

# Empty data frames, for the keyword. 
flu_tweets <- data.frame(stringsAsFactors = FALSE)

# The following function will search for the keyword 
# in the text field of the tweet record.
# If it found it, then it will extract and add it to the 
# other data frame.
for(i in 1:nrow(clean_tweets)) {
  if (grepl("flu", clean_tweets[i,]$text)) {
    flu_tweets <- rbind(flu_tweets, clean_tweets[i,]);
  }
}

# We extract the state and the then count how many per state and store it.
# Change the data frame name you want to map accordingly 
loc_count_flu <- data.frame(state=state.name, stringsAsFactors = FALSE);
loc_count_flu$count<-NA
for (i in 1:nrow(loc_count_flu)) {
  loc_count_flu[i,]$count <- length(which(flu_tweets$state == loc_count_flu[i,]$state));
}

# Plots the Map.
ggplot(loc_count_flu, aes(map_id = tolower(loc_count_flu$state))) + 
  coord_map() +
  geom_map(map = fifty_states, aes(fill = count)) +
  expand_limits(x = fifty_states$long, y= fifty_states$lat) +
  ggtitle("Count of Tweets Per State with 'flu' Keyword") +
  theme(plot.title = element_text(hjust = 0.5, face = 'bold')) +
  labs(fill = "Number of Tweets") +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        panel.background=element_blank()) +
  scale_fill_gradientn(guide = "legend",
                      colours = rainbow(5),
                      expand = c(0, 0),
                      limits = c(0, max(loc_count_flu$count)))

###### "Pneumonia" Keyword Tweets/State ######

# Empty data frames, for the 2 keywords. 
pneumonia_tweets <- data.frame(stringsAsFactors = FALSE)


# The following function will search for the keyword 
# in the text field of the tweet record.
# If it found it, then it will extract and add it to the 
# other data frame.
for(i in 1:nrow(clean_tweets)) {
  if (grepl("pneumonia", clean_tweets[i,]$text)) {
    pneumonia_tweets <- rbind(pneumonia_tweets, clean_tweets[i,]);
  }
}

# We extract the state and the then count how many per state and store it.
# Change the data frame name you want to map accordingly 
loc_count_pneumonia <- data.frame(state=state.name, stringsAsFactors = FALSE);
loc_count_pneumonia$count<-NA
for (i in 1:nrow(loc_count_pneumonia)) {
  loc_count_pneumonia[i,]$count <- length(which(pneumonia_tweets$state == loc_count_pneumonia[i,]$state));
}

# Plots the Map.
ggplot(loc_count_pneumonia, aes(map_id = tolower(loc_count_pneumonia$state))) + 
  coord_map() +
  geom_map(map = fifty_states, aes(fill = count)) +
  expand_limits(x = fifty_states$long, y= fifty_states$lat) +
  ggtitle("Count of Tweets Per State with 'pneumonia' Keyword") +
  theme(plot.title = element_text(hjust = 0.5, face = 'bold')) +
  labs(fill = "Number of Tweets") +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        panel.background=element_blank()) +
  scale_fill_gradientn(guide = "legend",
                       colours = rainbow(5),
                       expand = c(0, 0),
                       limits = c(0, max(loc_count_pneumonia$count)))
