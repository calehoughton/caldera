library(ggplot2)
library(dplyr)
library(tidyverse)

### BIRDS - dataframe is called birddata

# Calculate species richness by transect
birddata <- birddata %>%
  group_by(eventID, plot) %>%
  summarize(individualCount = sum(individualCount),
            speciesRichness = n_distinct(species))

#Plot for abundance
ggplot(birddata, aes(x = eventID, y = individualCount, fill = plot)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Bird Abundance by Transect",
       x = "Transect ID", y = "Total Bird Abundance") +
  theme_minimal()

# Plot for richness
ggplot(birddata, aes(x = eventID, y = speciesRichness, fill = plot)) +
  geom_bar(stat = "identity") +
  labs(title = "Bird Species Richness by Transect",
       x = "Transect ID", y = "Total Species Richness") +
  theme_minimal()
 
### TREES - dataframe is called treedata

# Calculate species richness by transect
treedata <- treedata %>%
  group_by(eventID, plot) %>%
  summarize(abundance = sum(individualCount),
            speciesRichness = n_distinct(species))

# Combine abundance and richness in a single data frame
combined_tree_data <- treedata %>%
  pivot_longer(cols = c(abundance, speciesRichness), names_to = "variable", values_to = "value")

# Create a stacked bar plot for trees
combined_tree_plot <- ggplot(combined_tree_data, aes(x = factor(eventID), y = value, fill = variable)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Abundance and Richness of Trees by Transect",
       x = "Transect ID", y = "Count") +
  theme_minimal()

# Display the combined tree plot
combined_tree_plot
