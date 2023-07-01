library(readxl)
library(ggplot2)
library(dplyr)
library(plotly)
library(webshot)

setwd('C:/Users/abedt/OneDrive/Desktop/Desktop_V2/PyCharm Projects/DSC_640/Week 1 & 2')

# Loading data

df_hotdog <- read_excel('hotdog-contest-winners.xlsm')
df_obama <- read_excel('obama-approval-ratings.xls')

# Column name change for hotdog dataset
colnames(df_hotdog) <- c('Year', 'Winner', 'Dogs_Eaten', 'Country', 'New_Record')


# Bar Chart

colors <- c()

for ( i in 1:length(df_hotdog$New_Record) ) {
  if (df_hotdog$New_Record[i] == 1) {
    colors <- c(colors, "orange")
  } else {
    colors <- c(colors, "navy")
  }
}

bar_chart <- plot_ly(df_hotdog, x = ~Year, y = ~Dogs_Eaten, type = 'bar',
               marker = list(color = colors, hoverinfo = 'none'))

bar_chart <- bar_chart %>% 
  layout(
    title = "Bar Chart - R \nHotdog Eating Contest \nWinning Number of Hotdogs Eaten",
    xaxis = list(showgrid = FALSE, 
                 title = ""), 
    yaxis = list(showgrid = FALSE, 
                 title = "Hotdogs Eaten",
                 titlefont = list(size = 22)),
    margin = list(l = 5, r = 5, b = 10, t = 30, pad = 10)
  )

bar_chart


# Stacked Bar Chart

stacked_chart <- plot_ly(df_obama, x = ~Approve, y = ~df_obama$Issue, type = 'bar', 
               orientation = 'h', marker = list(color = 'navy', 
                                                line = list(color = 'black', 
                                                            width = 2))) 
stacked_chart <- stacked_chart %>% add_trace(x = ~Disapprove, marker = list(color = 'orange')) 
stacked_chart <- stacked_chart %>% add_trace(x = ~None, marker = list(color = 'grey'))

stacked_chart <- stacked_chart %>%
  layout(xaxis = list(title = "",
                      showgrid = FALSE,
                      showline = TRUE,
                      showticklabels = TRUE,
                      zeroline = FALSE,
                      domain = c(0.15, 1)),
         yaxis = list(title = "",
                      showgrid = FALSE,
                      showline = TRUE,
                      showticklabels = FALSE,
                      zeroline = FALSE,
                      categoryorder = 'category descending'),
         barmode = 'stack',
         showlegend = FALSE,
         title = "Stacked Bar Chart - R - Obama Approval Percentages")
stacked_chart

# Pie Chart

df_hotdog_countries <- count(df_hotdog, Country, sort = FALSE)

pie <- plot_ly(df_hotdog_countries, labels = ~Country, values = ~n, type = 'pie',
               textinfo = 'percent', insidetextorientation = 'radial')
pie <- pie %>% 
  layout(title = 'Pie Chart - R - Percentage of Wins by Country',
         xaxis = list(showgrid = FALSE, 
                      zeroline = FALSE, 
                      showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, 
                      zeroline = FALSE, 
                      showticklabels = FALSE))
pie

# Donut Chart

donut <- plot_ly(df_hotdog_countries, labels = ~Country, values = ~n)

donut <- donut %>%
  add_pie(hole=0.5)

donut <- donut %>%
  layout(title = 'Donut Chart - R - Percentage of Wins by Country',
         xaxis = list(showgrid = FALSE, 
                      zeroline = FALSE, 
                      showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, 
                      zeroline = FALSE, 
                      showticklabels = FALSE))

donut
