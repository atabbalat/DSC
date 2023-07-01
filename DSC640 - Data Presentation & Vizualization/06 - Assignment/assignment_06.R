library(ggplot2)
library(dplyr)
library(tidyr)
library(readxl)
library("wordcloud2")
library("tm")
library(webshot)
library("htmlwidgets")

setwd('C:/Users/abedt/OneDrive/Desktop/Desktop_V2/PyCharm Projects/DSC_640/Week 11 & 12')

# Loading data

df_crime <- read.csv('crimeratesbystate-formatted.csv')

df_ed <- read.csv('education.csv')

df_live <- read.csv('live.csv')

# Histogram

df_crime_only <- subset(df_crime, select=-c(state))

histogram <- ggplot(gather(df_crime_only), aes(value)) + 
  geom_histogram(bins = 10, fill='blue') + 
  facet_wrap(~key, scales = 'free_x') +
  ggtitle("R - Histogram\nCrime")

histogram

# Box Plot

df_ed_only <- subset(df_ed, select=-c(state))

boxplt <- ggplot(gather(df_ed_only), aes(value)) + 
  geom_boxplot(fill='blue') + 
  facet_wrap(~key, scales = 'free_x') +
  ggtitle("R - Box Plot\nEducation")

boxplt

# Bullet Chart

states <- df_ed$state
reading <- df_ed$reading
avg <- df_ed[df_ed$state == 'United States', 'reading']

bullet_df <- data.frame(states, reading)[-1,]

bullet <- ggplot(data = df_ed, aes(x = state, y = reading)) +
  geom_rect(aes(xmin = -Inf, xmax = Inf, ymin = 0, ymax = 400), fill = '#F7D79F') +
  geom_rect(aes(xmin = -Inf, xmax = Inf, ymin = 400, ymax = 650), fill = '#FBBE4F') +
  geom_rect(aes(xmin = -Inf, xmax = Inf, ymin = 650, ymax = 800), fill = '#FFA500') +
  geom_col(width = 0.4, fill = "black") +
  geom_errorbar(aes(ymin = avg, ymax = avg), width = 0.2, size = 1, color = "darkgray") +
  coord_flip(expand = FALSE) +
  labs(title='R - Bullet Chart', subtitle = 'Education', x = 'State', y = 'SAT Reading Score') 

bullet


# World Cloud

docs <- Corpus(VectorSource(df_live['title']))
docs <- tm_map(docs, stripWhitespace)

tdm <- TermDocumentMatrix(docs)
m <- as.matrix(tdm)
v <- sort(rowSums(m), decreasing = TRUE)
d <- data.frame(word=names(v), freq=v)

set.seed(1200)

cloud <- wordcloud2(data=d, color='random-light', backgroundColor = 'black', size = 0.7)

cloud