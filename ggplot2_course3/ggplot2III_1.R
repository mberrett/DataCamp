#==================================================================================
# Data Visualization with ggplot2 (Part 3): 
#==================================================================================
# VIDEO: Introduction
#==================================================================================
# Chapter 1
# o Data savvy audience 

# Chapter 2
# o Suited for very specific data types

# Chapter 3
# o Maps & Animations

# Chapter 4
# o Introduction to grid
# o Manupulating graphical objects
# o ggplot_build()
# o gridExtra

# Chapter 5
# o Makinge extensions
# o New geom or stats from scratch 
#==================================================================================
# Aesthetics review
#==================================================================================
# We presented many aesthetics in the previous courses. 
# Which of the following is not a real aesthetic?
# o ymax
# o group
# o xend (can be used with line segments)
# o sd <- this one is not a real aesthetic 
# o size

#==================================================================================
# Refresher (1)
#==================================================================================
# A dataset called movies_small is coded in your workspace. 
# It is a random sample of 1000 observations from the larger movies dataset, 
# that's inside the ggplot2movies package. The dataset contains information on movies from IMDB.
# The variable votes is the number of IMDB users who have rated a movie and the rating
# (converted into a categorical variable) is the average rating for the movie.

# Create movies_small
pacman::p_load(ggplot2movies, tidyverse)
set.seed(123)
movies_small <- movies[sample(nrow(movies), 1000), ]
movies_small$rating <- factor(round(movies_small$rating))

# Explore movies_small with str()
str(movies_small)

# Build a scatter plot with mean and 95% CI
ggplot(movies_small, aes(x = rating, y = votes)) +
  geom_point() +
  stat_summary(fun.data = "mean_cl_normal",
               geom = "crossbar",
               width = 0.2,
               col = "red") +
  scale_y_log10()

#==================================================================================
# Refresher (2)
#==================================================================================
# Map the appropriate variables onto the x, y and col aesthetics.
# Add a geom_point() layer to make a scatter plot. 
# Set the attributes alpha = 0.5, size = .5, shape = 16.
# Transform both axes to log10 scales using scale_*_log10(). 
# The limits for the x axis are c(0.1,10) and c(100,100000) for the y axis.
# Make sure to use the appropriate labels: expression(log[10](Carat)) for the x axis;
# something similar for the y axis.
# Add a scale_color_brewer() call to use the "YlOrRd" palette.
# Use a coord_*() function to set the aspect ratio to 1.
# Set the theme to theme_classic().

# Reproduce the plot
ggplot(diamonds, aes(carat, price, col = color))+
  geom_point(alpha = 0.5, size = .5, shape = 16)+
  scale_x_log10(expression(log[10](Carat)), limits = c(0.1,10))+
  scale_y_log10(expression(log[10](Price)), limits = c(100, 100000)
  )+
  scale_color_brewer(palette = "YlOrRd")+
  coord_equal()+
  theme_classic()

#==================================================================================
# Refresher (3)
#==================================================================================
# Add smooth layer and facet the plot
ggplot(diamonds, aes(x = carat, y = price, col = color)) +
  geom_point(alpha = 0.5, size = .5, shape = 16) +
  scale_x_log10(expression(log[10](Carat)), limits = c(0.1,10)) +
  scale_y_log10(expression(log[10](Price)), limits = c(100,100000)) +
  scale_color_brewer(palette = "YlOrRd") +
  coord_equal() +
  theme_classic()+
  stat_smooth(method = "lm")+
  facet_grid(.~cut)

#==================================================================================
# VIDEO: Box Plots
#==================================================================================
# Statistical plots
# o Academic audience
# o 2 common types
#   - Box plots
#   - Density plots
# Case study: 2D box plots

# Box plot
# o John Tukey - Exploratory Data Analysis
# o Visualizing the 5 number summary
#   o minimum, Q1, Q2(median), Q3, Q4, maximum
#   o IQR = Q3 - Q1

# Mean and Standard Deviation are no good for skewed distributions
#   o They're not robust: easily skewed by extreme 

# The 5 number summary
# o Give a better sense of the distribution
# o Each of the four segments represent 25% of the data
# o The ability to show extreme values as distinct features 
# o outside the range (1.5 times the IQR)
# o Whisker goes up to highest point within the fence
# o Middle line is median not the mean

#==================================================================================
# Transformations
#==================================================================================
# movies_small is available

# Add a boxplot geom
d <- ggplot(movies_small, aes(x = rating, y = votes)) +
  geom_point() +
  geom_boxplot() +
  stat_summary(fun.data = "mean_cl_normal",
               geom = "crossbar",
               width = 0.2,
               col = "red") 

# Untransformed plot
d 

# Transform the scale
d + scale_y_log10()

# Transform the coordinates
d + coord_trans(y = "log10")
coord_tra
#==================================================================================
# VIDEO: Box Plots
#==================================================================================
# If you only have continuous variables, 
# you can convert them into ordinal variables using any of the following functions:

# o cut_interval(x, n) makes n groups from vector x with equal range.
# o cut_number(x, n) makes n groups from vector x with (approximately) 
#   equal numbers of observations.
# o cut_width(x, width) makes groups of width width from vector x.

# Plot object p
p <- ggplot(diamonds, aes(x = carat, y = price))

# Use cut_interval
p + geom_boxplot(aes(group = cut_interval(carat, n = 10)))

# Use cut_number
p + geom_boxplot(aes(group = cut_number(carat, n = 10)))

# Use cut_width
p + geom_boxplot(aes(group = cut_width(carat, width = 0.25)))
#==================================================================================
# Understanding quartiles
#==================================================================================
# Be aware that there are many ways to calculate the IQR, short for inter-quartile range
# (i.e. Q3−Q1Q3−Q1). These are defined in the help pages for the quantile() function:

?quantile
# The IQR becomes more consistent across methods as the sample size increases.


