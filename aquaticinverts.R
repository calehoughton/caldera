library(ggplot2)
library(dplyr)
library(patchwork)
#Dataframe called aquaticinverts

#Create a plot of aquatic invertebrate abundance
ggplot(aquaticinverts, aes(x = eventID, y = individualCount, fill = plot)) +
  geom_bar(stat = "sum", position = "stack") +
  labs(title = "Total Kick-Sampling Site Yield",
       x = "Site ID",
       y = "Total Abundance") +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 8, angle = 45, hjust = 1))

# Calculate invertebrate richness
aquaticinverts_diversity <- aquaticinverts %>%
  group_by(eventID, plot) %>%
  summarise(total_diversity = length(unique(order)))

# Create a barplot for invertebrate diversity
ggplot(aquaticinverts_diversity, aes(x = eventID, y = total_diversity, fill = plot)) +
  geom_col() +
  labs(title = "Aquatic Invertebrate Richness by Site",
       x = "Site ID",
       y = "Invertebrate Richness") +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 8, angle = 45, hjust = 1))



# Creating an order for the most common species
custom_order_north <- c("ephemeroptera", "plecoptera", "diptera", "trichoptera", "gordioidea", "coleoptera")
custom_order_south <- c("oligochaete", "coleoptera", "odonata", "diptera", "plecoptera", "ephemeroptera", "trichoptera")

# Subset the data for North and South plots
aquaticinverts_north <- aquaticinverts[aquaticinverts$plot == "North", ]
aquaticinverts_south <- aquaticinverts[aquaticinverts$plot == "South", ]

# Create separate bar plots for North and South
plot_north <- ggplot(aquaticinverts_north, aes(x = factor(order, levels = custom_order_north), y = individualCount, fill = "North")) +
  geom_bar(stat = "identity") +
  labs(title = "Abundance of Invertebrate Orders (North)",
       x = "Invertebrate Order",
       y = "Abundance") +
  scale_fill_manual(values = "#F8766D") +
  guides(fill = FALSE) +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 8, angle = 45, hjust = 1))

plot_south <- ggplot(aquaticinverts_south, aes(x = factor(order, levels = custom_order_south), y = individualCount, fill = "South")) +
  geom_bar(stat = "identity") +
  labs(title = "Abundance of Invertebrate Orders (South)",
       x = "Invertebrate Order",
       y = "Abundance") +
  scale_fill_manual(values = "#00BFC4") +
  guides(fill = FALSE) +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 8, angle = 45, hjust = 1))

# Arrange plots side by side
plots_side_by_side <- plot_north + plot_south +
  plot_layout(ncol = 2)

# Display the plots
plots_side_by_side

