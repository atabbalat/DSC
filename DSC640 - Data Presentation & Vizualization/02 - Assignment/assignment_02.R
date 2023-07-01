library(readxl)
library(ggplot2)
library(dplyr)
library(plotly)
library(webshot)

setwd('C:/Users/abedt/OneDrive/Desktop/Desktop_V2/PyCharm Projects/DSC_640/Week 3 & 4')

# Loading data

df <- read_excel('world-population.xlsm')

df$Population1000 <- df$Population / 1000000

# Line Chart

line_chart <- plot_ly(df, x=~Year, y=~Population1000, type='scatter',mode= 'lines', color = 'orange')

line_chart <- line_chart %>%
  layout(
    title = "Line Chart - R \nWorld Population per Year",
    xaxis = list(showgrid = FALSE, 
                 title = ""), 
    yaxis = list(showgrid = FALSE, 
                 title = "Population in millions",
                 titlefont = list(size = 22)),
    margin = list(l = 5, r = 5, b = 10, t = 30, pad = 10)
  )
line_chart

# Step Chart

step_chart <- plot_ly(df, x=~Year, y=~Population1000, type='scatter',mode='lines', line=list(shape='hv'), color = 'orange')

step_chart <- step_chart %>%
  layout(
    title = "Step Chart - R \nWorld Population per Year",
    xaxis = list(showgrid = FALSE, 
                 title = ""), 
    yaxis = list(showgrid = FALSE, 
                 title = "Population in millions",
                 titlefont = list(size = 22)),
    margin = list(l = 5, r = 5, b = 10, t = 30, pad = 10)
  )
step_chart