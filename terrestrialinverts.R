library(vegan)
# Dataframe called terrestrialinverts

# Aggregating individual counts at the family and plot level
family_plot_counts <- aggregate(individualCount ~ family + plot, data = terrestrialinverts, sum)

# Calculate Shannon diversity index for family within each plot
diversity_results <- tapply(family_plot_counts$individualCount, family_plot_counts$plot, function(x) diversity(x))

# Convert the results to a data frame
diversity_df <- data.frame(Plot = names(diversity_results), Diversity = diversity_results)

# Plot the diversity results
barplot(diversity_df$Diversity, names.arg = diversity_df$Plot, col = c("skyblue", "lightgreen"), main = "Diversity Across Families and Plots", ylab = "Shannon Diversity Index", legend.text = TRUE)

# Order families within each plot by total individual counts in descending order
ordered_families <- family_plot_counts[order(family_plot_counts$individualCount, decreasing = TRUE), ]

# I want two plots side by side
par(mfrow = c(1, 2))

# Plot the rank abundance barplot for each plot
max_count <- max(ordered_families$individualCount) #calculating so that they can share the same y-axis
for (i in seq_along(unique(ordered_families$plot))) {
  current_plot <- unique(ordered_families$plot)[i]
  current_data <- subset(ordered_families, plot == current_plot)
  
  barplot(current_data$individualCount, names.arg = NA, col = "skyblue", main = paste("Rank-Abundance Plot", current_plot), ylab = "Total Individual Counts", xlab = "Species Rank", ylim = c(0, max_count), las = 2)
}

