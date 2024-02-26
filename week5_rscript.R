# the following exercises are a test in disguise. 
# what do you think about the coding? 
# can you think of any improvements to the following?

rm(list=ls()) # always clean up your environment! 

install.packages("tidyverse") 
library(tidyverse)
library(ggplot2)

## PROBLEM 1 ##

# visualizing your data is important!
# summary statistics can be highly misleading, and simply plotting the data can reveal a lot more!
# Lets look at the Anscombe’s Quartet data. There are four different data sets.
# Anscombe, F. J. (1973). "Graphs in Statistical Analysis". American Statistician. 27 (1): 17–21. doi:10.1080/00031305.1973.10478966. JSTOR 2682899.

anscombe_quartet = readRDS("anscombe_quartet.rds")

# let's explore the dataset 
str(anscombe_quartet)

# what does the function str() do? 
#display internal structure of the dataset

# let's check some summary statistics:

anscombe_quartet %>% 
  group_by(dataset) %>% 
  summarise(
    mean_x    = mean(x),
    mean_y    = mean(y),
    min_x     = min(x),
    min_y     = min(y),
    max_x     = max(x),
    max_y     = max(y),
    crrltn    = cor(x, y)
  )

# what do the summary statistics tell us about the different datasets? 
#all datasets have identical mean values of x and y, and highly similar correlations, but have distinct min and max x and y values.

# let's plot the data with ggplot:

require(ggplot2)

ggplot(anscombe_quartet, aes(x=x,y=y)) +
  geom_point() + 
  geom_smooth(method = "lm",formula = "y ~ x") +
  facet_wrap(~dataset)

#save the plot

ggsave("anscombe_quartet.png", width = 20, height = 20, units = "cm")

# what do the plots tell us about the different datasets? 
# it visualises the relationship between x and y values in each dataset 

# describe the relationship between x and y in the different datasets. 
# 1: fairly linear, 2: quadratic, 3: very linear with what looks like an outlier, 4: all data points except 1 have the same x value and different y values

# would linear regression be an appropriate statistical model to analyse the x-y relationship in each dataset?
# It is suitable for 3 and potentially for 1, but not for 2 and 4

# what conclusions can you draw for the plots and summary statistics? 
# summary statistics don't accurately capture characteristics of the dataset, so visualisation is very important.

## PROBLEM 2 ##

# load in the datasaurus dataset
dd = readRDS("datasaurus_dozen.rds")

# explore the dataset 
head(dd)
summary(dd)

# how many rows and columns does the datasaurus_dozen file have? 
# 2 columns and 1846 rows

# plot the dataset 

ggplot(dd, aes(x=x,y=y)) +
  geom_point() +
  facet_wrap(~dataset)


# calculate the correlations and summary statistics for x and y in all datasets: 

dd %>% 
  group_by(dataset) %>% 
  summarise(
    mean_x    = mean(x),
    mean_y    = mean(y),
    min_x     = min(x),
    min_y     = min(y),
    max_x     = max(x),
    max_y     = max(y),
    crrltn    = cor(x, y)
  )

# Plot the relationships between x and y in each dataset including the line of best fit.

plot2 <- ggplot(dd, aes(x=x,y=y)) +
  geom_point() + 
  geom_smooth(method = "lm",formula = "y ~ x") +
  facet_wrap(~dataset)

# save the plot 

ggsave("plot2.png")

# what conclusions can you draw for the plots and summary statistics? 
# plots represent different images, x and y vales are not correlated in a linear manner in any of the datasets
