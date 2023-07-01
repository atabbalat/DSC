library(ggplot2)
library(dplyr)
library(tidyr)
library(rgdal)
library(usmap)
library(maptools)

setwd('C:/Users/abedt/OneDrive/Desktop/Desktop_V2/PyCharm Projects/DSC_640/Week 9 & 10')

# Loading data

df_costco <- read.csv('costcos-geocoded.csv')

df_ppg <- read.csv('ppg2008.csv')

# Heat Map

df_ppg_10 <- df_ppg[c(1:10), c(1:11)]
df_ppg_10 <- data.frame(df_ppg_10)
df_ppg_10[c(2:11)] <- scale(df_ppg_10[c(2:11)])

df_ppg_longer <- df_ppg_10 %>% pivot_longer(!Name,
                                            names_to = 'Type',
                                            values_to = 'Stat')

heat <- ggplot(df_ppg_longer, aes(x=factor(Type, level=c('G', 'MIN', 'PTS',
                                                         'FGM', 'FGA', 'FGP',
                                                         'FTM', 'FTA', 'FTP',
                                                         'X3PM')),
                                  y=Name, fill=Stat)) +
  geom_tile(show.legend = FALSE) +
  geom_text(aes(label = round(Stat, digits = 2)), color = 'white', size = 3) +
  coord_fixed() +
  scale_fill_gradient(low = "black", high = "red") +
  ggtitle("R - Heat Map\nNBA Performance") +
  xlab('Stat')

heat

# Spatial Chart

shape <- readOGR('shape/States_shapefile.shp', stringsAsFactors = FALSE)

latLong <- data.frame(lon=df_costco$Longitude, lat=df_costco$Latitude)

transformData <- usmap_transform(latLong)

spatial <- plot_usmap(regions = "states") +
  labs(title = "R - Spatial Chart", subtitle = "Costco Locations") + 
  theme(panel.background=element_blank()) +
  geom_point(data = transformData, aes(x = x, y = y), color = 'red', alpha = 0.5)

spatial


# Contour Chart

X <- sort(df_ppg$MIN, decreasing = FALSE)
Y <- sort(df_ppg$PTS, decreasing = FALSE)
Z <- sqrt(outer(X ^ 2, Y ^ 2, '+'))

df_contour <- data.frame(x=rep(X, each=length(Y)), y=rep(Y, length(X)), z=c(Z))

# Plot the contour chart
contourChart <- filled.contour(Z, plot.title = title(main = "R - Contour\nNBA Performance", 
                                     xlab = 'Minutes (%)',  ylab = 'Points(%)', cex.main = 0.8))

contourChart  
