install.packages("rtweet")
install.packages("fiftystater")
library(rtweet)
library(fs)
library(ggmap)
library(fiftystater)
library(ggplot2)

######## Lab 1, Part 3 Credentials #######
# Using rtweet to find tweets
# The following keys are mine (rakshitm), you can use them
# or use yours
create_token(
  app = "SOLR_CSE535",
  consumer_key = "MiYJPLSSbO5PvZHXcoACrUqIA",
  consumer_secret = "gVL0SrKvcDgdULoASJwKA9H0Mq6ZGAcBsxf4UVakp4EelTt3gP",
  access_token = "1068558463083655168-SSR9ItGPZID9uGbhVEFgYYuDEn40zX",
  access_secret = "8nxOu8PMZtim7rrn6hNJ8R05xl5bvCgyFsmDxpHUsVl62")

register_google(key = "AIzaSyBkxf5ZwATGGsRfjmDh73786lucI--p54o")

####### Lab 1, Part 3 Twitter data collection #######

# if you want to search upto a specific date,
# please mention it here. 
until <- "2019-02-26"

# the keywords to query against.
q <- "flu OR influenza OR Tamiflu OR pneumonia"

# Scan to get the tweets and it will be 
# saved to the get_tweets data.frame.
get_tweets <- search_tweets(q, 
                     n = 18000,
                     geocode = lookup_coords("usa"), 
                     include_rts = FALSE,
                     lang = "en",
                     search_type = "recent",
                     until=until)

# Function to separate the latitude and longitude
# from the tweet record.
rt2 <- lat_lng(get_tweets)

# Flatten the whole dataset.
rt2 <- apply(rt2,2,as.character)

# Write the file name you want to save to.
file_create(path("flu_geocoded_rt2.csv"))

# Flattens the array within array.
rt2 <- apply(rt_clean3,2,as.character)

# Save it to the file.
write.csv(clean_tweets, file = "flu_clean.csv")


####### Lab 1 Part 3 Twitter data cleaning and plotting #######

# Read the file that contains all the needed tweets
# that should be loaded.
# We can use data from previous part here, if we didn't save it. 
all_tweets <- read.csv(file.choose())

# New array to store clean geotagged tweets
# We initialize this to store all the clean tweets.
# It only contains the tweets with latitude, longitude and state.
clean_tweets <- data.frame(stringsAsFactors = FALSE)

# To check the all the tweets are unique.
# It should return true.
print(length(unique(all_tweets$status_id)) == nrow(all_tweets))

# First Step.
# Remove tweets that are not geo-tagged, by checking for "NA" values.
# This way we are skimming out data for the next part.
for(i in 1:nrow(all_tweets)) {
  if (!is.na(all_tweets[i,]$lat) && !is.na(all_tweets[i,]$lng)) {
    clean_tweets <- rbind(clean_tweets, all_tweets[i,]);
  }
};

# Second Step.
# Reverse geocode to get the full address of the lat/lon
# then we go through the response, which is a list.
# We go from google and see inside which part of the response does the state sit. 
# It generally sits in the list itemthat has type "administrative_area_level_1".
# Once we know where the state can potentially be, 
# we access that list item and retrive the state from it.
clean_tweets$state<-NA
for(i in 1:nrow(clean_tweets)) {
  print(i);
  temp_loc <- revgeocode(as.numeric(c(clean_tweets[i,90],clean_tweets[i,89])), output = "all");
  if (!is.na(temp_loc)) {
    temp_loc <- c(temp_loc$results[[1]]$address_components);
    for (j in temp_loc) {
      if (j$types[1] == "administrative_area_level_1") {
        clean_tweets[i,]$state = j$long_name;
      }
    }
  }
}

# Third Step. 
# A seperate data frame that will get the count of tweets/state
loc_count_all <- data.frame(state=state.name, stringsAsFactors = FALSE);
loc_count_all$count<-NA
for (i in 1:nrow(loc_count_all)) {
  loc_count_all[i,]$count <- length(which(clean_tweets$state == loc_count_all[i,]$state));
}

# Exact number of 50 State Tweets
print(sum(loc_count_all$count))

# Plotting the heatmap.
ggplot(loc_count_all, aes(map_id = tolower(loc_count_all$state))) + 
  coord_map() +
  geom_map(map = fifty_states, aes(fill = count)) +
  expand_limits(x = fifty_states$long, y= fifty_states$lat) +
  ggtitle("Count of Tweets Per State") +
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
                       limits = c(0, max(loc_count_all$count)))
