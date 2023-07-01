library(ggplot2)
library(dplyr)
library(plotly)
library(reshape2)

setwd('C:/Users/abedt/OneDrive/Desktop/Desktop_V2/PyCharm Projects/DSC_640/Week 7 & 8')

# Loading data

df_crime <- read.csv('crimerates-by-state-2005.csv')

df_birth_rate_yearly <- read.csv('birth-rates-yearly.csv')

# Data modification

df_crime_m <- melt(df_crime, id=c('state', 'population'), variable.name= 'crime_type')

df_crime_xusa <- df_crime_m[df_crime_m$state != 'United States', ]

df_crime_usa <- df_crime_m[df_crime_m$state == 'United States', ]

df_birth_rate_1965_2000 <- df_birth_rate_yearly %>%
  filter(year == 2000 | year == 1965)

df_birth_rate_1965_2000 <- df_birth_rate_1965_2000[order(df_birth_rate_1965_2000$year), ]
df_birth_rate_1965_2000$year <- as.character(df_birth_rate_1965_2000$year) 


# Scatter Plot

scatter <- df_crime_xusa %>%
  ggplot(aes(x = population, y = value, color = crime_type)) + 
  geom_point() +
  ggtitle("R - Scatter Plot \nCrime Rate By Type") +
  guides(size = 'none') +
  xlab("Population") + 
  ylab("Crime Rates") +
  scale_x_continuous(labels = scales::comma)

scatter

# Bubble Chart

bubble <- df_crime_usa %>% 
  ggplot(aes(x = value, y = state)) +
  geom_point(aes(color = crime_type, size = value), alpha = 0.5) +
  scale_size(range = c(0.8, 15), guide = 'none') +
  ggtitle("R - Bubble Chart \nCrime Types in the US") + 
  xlab("Crime Rates") +
  ylab(NULL) +
  theme(legend.position="bottom")

bubble

# Density Plot

density_Plot <- df_birth_rate_1965_2000 %>%
  ggplot(aes(x = rate, fill = year)) +
  geom_density(alpha = 0.3) +
  ggtitle("Density Plot - R\nBirth Rates 1965 vs 2000") + 
  labs(fill = 'Year')+
  scale_x_continuous(name="Birth Rates", limits=c(0, 70))+
  scale_fill_manual(values = c("blue", "orange"))

density_Plot
