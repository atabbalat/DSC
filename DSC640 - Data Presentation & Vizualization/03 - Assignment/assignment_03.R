library(ggplot2)
library(dplyr)
library(plotly)
library(treemapify)

setwd('C:/Users/abedt/OneDrive/Desktop/Desktop_V2/PyCharm Projects/DSC_640/Week 5 & 6')

# Loading data

dfu <- read.csv("unemployement-rate-1948-2010.csv")

dfe <- read.table("expenditures.txt", sep="\t", header=TRUE)

# Tree map Chart

## Top 5 expenditures 
dfe_top5 <- dfe %>%
  group_by(category) %>%  
  summarise(top = sum(expenditure)) %>% 
  arrange(desc(top)) %>% 
  top_n(5)

## Plot
tree <- ggplot(dfe_top5, aes(area = top, fill = category, label = category)) +
  geom_treemap() +
  geom_treemap_text(colour = "black", min.size = 0.3,
                    place = "centre", padding.x = grid::unit(3, "mm"), padding.y = grid::unit(3, "mm")) +
  theme(legend.position = "none") +
  scale_fill_brewer(palette = "OrRd") +
  ggtitle("R - Treemap \nTop 5 Categories by Expenditure")

tree

# Area Chart

## Expenditure per year
dfe_year <- dfe %>%
  group_by(year) %>%  
  summarise_at(vars(expenditure), sum)

## Plot
area <- ggplot(dfe_year, aes(x = year, y = expenditure)) +
  geom_area(fill = "orange") +
  ggtitle("Area Chart - R \nExpenditures By Year") +
  xlab('Year') + 
  ylab("Expenditures")

area

# Stacked Area Chart

## Creating a 10 year stacked area chart 2009, 1999, 1989

dfu$Year <- as.character(dfu$Year)
years <- c("1989", "1999", "2009")
three_years <- filter(dfu, Year %in% years)

stacked <- ggplot(three_years, aes(x = Period, y = Value, fill = Year, group = Year)) + 
  geom_area(position = 'stack') +
  ggtitle("R - Stacked Area Chart\n10 Yr Unemployment Rates") +
  xlab('Year') + 
  scale_x_discrete(labels=c('1', '2', '3', '4', '5', '6', '7', 
                            '8', '9', '10', '11', '12')) +
  ylab("Unemployment Rates") +
  scale_fill_manual(values = c('yellow', 'orange', 'red'))

stacked



