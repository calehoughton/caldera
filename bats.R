library(dplyr)
library(ggplot2)
#dataframe is called batdata

# Grouping by sampling location
batdata <- batdata %>%
  group_by(eventID, plot) %>%
  summarize(species_richness = n_distinct(species),
            total_abundance = n())  

#Plotting for abundance
ggplot(batdata, aes(x = eventID, y = total_abundance, fill = plot)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Bat Abundance by Sampling Event",
       x = "Transect ID", y = "Total Bat Abundance") +
  theme_minimal()

#Plotting for richness
ggplot(batdata, aes(x = eventID, y = species_richness, fill = plot)) +
  geom_bar(stat = "identity") +
  labs(title = "Bat Species Richness by Sampling Event",
       x = "Sampling Event", y = "Total Bat Richness") +
  theme_minimal()
