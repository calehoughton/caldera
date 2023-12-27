
###
#WATER QUALITY CALCULATIONS
###

#N1stream
n1s <- (10 + #10 and other scores multiplied below by are the BMWP scores found from Hamsel et al., 2006.
  10 +
  5 + 
  6 +
  10) /
    5 #I divide by the total number of aquatic inverts here
#N2stream
ns2 <- (10 + 10 + 5)/3
#N3stream
ns3 <- (10+10+5+5) / 4
#N4stream
ns4 <- (10 + 10 + 5 + 10 + 10 + 10 + 5) / 7
#N5stream
ns5 <- (10+10+5+10+10)/5
#S1marsh
s1m <- (5 + 6)/2
#S1stream
s1s <- (5 + 5 + 1)/3
#S2marsh
s2m <- (10 + 6)/2
#S2stream
s2s <- (10 + 5)/2
#S3marsh
s3m <- (6 + 10)/2
#S3stream
s3s <- 5/1
#S4marsh
s4m <- (5+5+1+10)/4
#S4stream
s4s <- (10 + 1) /2
#S5marsh
s5m <- (1 + 6 + 5)/3
#S5stream
s5s <- (5 + 10 + 5 + 10)/4
#S6marsh
s6m <- 6/1

waterqualitydataframe <- data.frame(
  Variable = c("n1s", "ns2", "ns3", "ns4", "ns5", "s1m", "s1s", "s2m", "s2s", "s3m", "s3s", "s4m", "s4s", "s5m", "s5s", "s6m"),
  Value = c(n1s, ns2, ns3, ns4, ns5, s1m, s1s, s2m, s2s, s3m, s3s, s4m, s4s, s5m, s5s, s6m),
  Plot = c(rep("North", 5), rep("South", 11))
)

mean_values <- aggregate(Value ~ Plot, data = waterqualitydataframe, mean)

# Create a bar plot of the water quality data
ggplot(waterqualitydataframe, aes(x = Variable, y = Value, fill = Plot)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_hline(data = mean_values, aes(yintercept = Value, color = Plot), linetype = "dashed", size = 1) +
   labs(title = "Bar Plot of Variable Values by Region with Mean Lines",
       x = "Sampling site",
       y = "Water Quality ASPT") +
  theme_minimal()
