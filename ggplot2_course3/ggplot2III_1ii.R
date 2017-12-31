#===========================================================================================
# VIDEO: Density plots
#===========================================================================================
# Density plot
# o Distribution of univariate data
# o Statistics
  # o Probability Density Function (PDF)
    # Standard Normal Curve
    # t-statistic 
    # chi-sq
    # F-statistic
# o Theoretical: based on formula
# o Empirical: based on data 

# Kernel Density Estimate (KDE)
# A sum of 'bumps' placed at observations.
# The kernel function determines the shape of the bumps
# while the window width, h, determines their width.

# Example - Sum of bumps
(x <- c(0,1,1.1,1.5,1.9,2.8,2.9,3.5))
# many overlapping lines result in a higher value. ergo a higher density 

# Empirical Probability Density Function 
# mode = value at which probability density funtion has its maximum value

# Bandwith - h
# Remember: Density plots are representations of the underlying distribution!

# Intermediate steps. Plot extends beyond limits of data (0 and 3.5)
# geom_density() cuts off the curve at the minimum and maximum (happens for every bandwith)
# o However, this means the area under the curve is no longer 1

#===========================================================================================
# geom_density()
#===========================================================================================
library(readr) ; library(ggplot2)
test_data = read_csv('test_data.csv')

# test_data is available
test_data

# Calculating density: d
d <- density(test_data$norm)

# Use which.max() to calculate mode
mode <- d$x[which.max(d$y)]

# Finish the ggplot call
# The following default parameters are used 
# (you can specify these arguments both in density() as well as geom_density()):
# o bw = "nrd0", telling R which rule to use to choose an appropriate bandwidth.
# o kernel = "gaussian", telling R to use the Gaussian kernel.

ggplot(test_data, aes(x = norm)) +
  geom_rug() +
  geom_density() +
  geom_vline(xintercept = mode, col = "red")

#===========================================================================================
# Combine density plots and histogram
#===========================================================================================
# Sometimes it is useful to compare a histogram with a density plot. 
# However, the histogram's y-scale must first be converted to frequency 
# instead of absolute count. After doing so, you can add an emperical PDF 
# using geom_density() or a theoretical PDF using stat_function().

# test_data is available

# Arguments you'll need later on
fun_args <- list(mean = mean(test_data$norm), sd = sd(test_data$norm))

# Finish the ggplot
ggplot(test_data, aes(x = norm))+
  geom_histogram(aes(y =..density..))+
  geom_density(col = 'red')+
  stat_function(fun = dnorm, args = fun_args, col = 'blue')

#===========================================================================================
# Adjusting density plots
#===========================================================================================
# There are three parameters that you may be tempted to adjust in a density plot:

# bw - the smoothing bandwidth to be used, see ?density for details
# adjust - adjustment of the bandwidth, see density for details
# kernel - kernel used for density estimation, defined as
# "g" = gaussian
# "r" = rectangular
# "t" = triangular
# "e" = epanechnikov
# "b" = biweight
# "c" = cosine
# "o" = optcosine

# In this exercise you'll use a dataset containing only four points, small_data, 
# so that you can see how these three arguments affect the shape of the density plot.

# The vector get_bw contains the bandwidth that is used by default in geom_density(). 
# p is a basic plotting object that you can start from.

small_data <- data.frame(x = c(-3.5, 0, 0, 6))

# small_data is available
small_data

# Get the bandwith
get_bw <- density(small_data$x)$bw

# Basic plotting object
p <- ggplot(small_data, aes(x = x)) +
  geom_rug() +
  coord_cartesian(ylim = c(0,0.5))

# Create three plots
p + geom_density()
p + geom_density(adjust = 0.25)
p + geom_density(bw = 0.25 * get_bw)

# Create two plots
p + geom_density(kernel = "r")
p + geom_density(kernel = "e")
#===========================================================================================
# VIDEO: Multiple Groups/Variables
#===========================================================================================
# Groups 
# Levels within a factor variable
library(tidyverse)
names(msleep)
mammals <- msleep %>%
  select(vore, sleep_total) %>%
  drop_na()
head(mammals)
mammals$vore <- factor(mammals$vore)
levels(mammals$vore)

# Up to this point we would have used a plot like this:
# Jittered points
ggplot(mammals, aes(x = vore, y = sleep_total))+
  geom_point(position = position_jitter(0.2))

# Box plot
ggplot(mammals, aes(x = vore, y = sleep_total))+
  geom_boxplot()
# o Although we could use box plots, in this case, it's not really reasonable;
#   since the insectivore group only has 5 observations
# o The problem with box plots is that they don't show information about the n of observations
# o We can remedy this problem by setting the width of each group relative to their n value 
# Box plot (2)
ggplot(mammals, aes(x = vore, y = sleep_total))+
  geom_boxplot(varwidth = TRUE)

# Density plot
ggplot(mammals, aes(x = sleep_total, fill = vore))+
  geom_density(col = NA, alpha = 0.35)
# Advantage: we can overlay density plots and compare distributions more easily 
# However, we once again lose information about group size (insectivores seem abundant)
# Solution: add weights
mammals <- mammals %>%
  group_by(vore) %>%
  mutate(n = n()/nrow(mammals))
# Weighted Density plot
ggplot(mammals, aes(x = sleep_total, fill = vore))+
  geom_density(aes(weight = n), col = NA, alpha = 0.35)

# Violin plot
# o Relatively new, but gaining in popularity
# Density plot
ggplot(mammals, aes(x = vore, y = sleep_total))+
  geom_violin()
# Puts a density plot onto a vertocal axis and then mirrors to create a symmetrical 2D shape
# can aid in comparing distributions 
# We should also consider weighting each group
# Weighted Violin plot
ggplot(mammals, aes(x = vore, 
                    y = sleep_total,
                    fill = vore))+
  geom_violin(aes(weight = n), col = NA)

# Compare separate vairables
dim(faithful)
head(faithful)

# First look
ggplot(faithful, aes(x = waiting, y = eruptions)) +
  geom_point()
# At the outset relationship seems linear, which is correct
# but more subtle: data is also bimodal on both axes 
# that is, you either wait a long time and get a long eruption
# or you wait a short time and get a short eruption
# with relatively few data points in between

# 2D density plot
ggplot(faithful, aes(x = waiting, y = eruptions)) +
  geom_density_2d()
# the more concentric a ring is, the higher the density
# Monochromatic color scales 
ggplot(faithful, aes(x = waiting, y = eruptions)) +
  stat_density_2d(geom = "tile",
                  aes(fill = ..density..),
                  contour = FALSE)
# Viridis
pacman::p_load(viridis)
ggplot(faithful, aes(x = waiting, y = eruptions)) +
  stat_density_2d(geom = "tile",
                  aes(fill = ..density..),
                  contour = FALSE)+
  scale_fill_viridis()
# Viridis color scale has recently gained in popularity 

# Grid of circles
ggplot(faithful, aes(x = waiting, y = eruptions)) +
  stat_density_2d(geom = "point",
                  aes(size = ..density..),
                  n = 20, contour = FALSE)+
  scale_size(range = c(0, 9))

#===========================================================================================
# Box plots with varying width
#===========================================================================================
# A drawback of showing a box plot per group, is that you don't have any indication 
# of the sample size, nn, in each group, that went into making the plot. One way of
# dealing with this is to use a variable width for the box, which reflects differences in nn.

# Can you add some good-looking box plots to the basic plot coded on the right?

# Finish the plot
ggplot(diamonds, aes(x = cut, y = price, col = color ))+
  geom_boxplot(varwidth = TRUE)+
  facet_grid(.~color)

#===========================================================================================
# Mulitple density plots
#===========================================================================================
# Density plot from before
ggplot(mammals, aes(x = sleep_total, fill = vore)) +
  geom_density(col = NA, alpha = 0.35) +
  scale_x_continuous(limits = c(0, 24)) +
  coord_cartesian(ylim = c(0, 0.3))

# Finish the dplyr command
library(dplyr)
mammals2 <- mammals %>%
  group_by(vore) %>%
  mutate(n = n() / nrow(mammals))

# Density plot, weighted
ggplot(mammals2, aes(x = sleep_total, fill = vore)) +
  geom_density(aes(weight = n), col = NA, alpha = 0.35) +
  scale_x_continuous(limits = c(0, 24)) +
  coord_cartesian(ylim = c(0, 0.3))

# Violin plot
ggplot(mammals, aes(x = vore, y = sleep_total, fill = vore)) +
  geom_violin()

# Violin plot, weighted
ggplot(mammals2, aes(x = vore, y = sleep_total, fill = vore)) +
  geom_violin(aes(weight = n), col = NA)
#===========================================================================================
# Mulitple density plots (2)
#===========================================================================================
# Individual densities
ggplot(mammals[mammals$vore == "insecti", ], aes(x = sleep_total, fill = vore)) +
  geom_density(col = NA, alpha = 0.35) +
  scale_x_continuous(limits = c(0, 24)) +
  coord_cartesian(ylim = c(0, 0.3))

# With faceting
ggplot(mammals, aes(x = sleep_total, fill = vore)) +
  geom_density(col = NA, alpha = 0.35) +
  scale_x_continuous(limits = c(0, 24)) +
  coord_cartesian(ylim = c(0, 0.3)) +
  facet_wrap(~vore, nrow = 2)

# Note that by default, the x ranges fill the scale
ggplot(mammals, aes(x = sleep_total, fill = vore)) +
  geom_density(col = NA, alpha = 0.35) +
  scale_x_continuous(limits = c(0, 24)) +
  coord_cartesian(ylim = c(0, 0.3))

# Trim each density plot individually
ggplot(mammals, aes(x = sleep_total, fill = vore)) +
  geom_density(col = NA, alpha = 0.35, trim = TRUE) +
  scale_x_continuous(limits=c(0,24)) +
  coord_cartesian(ylim = c(0, 0.3))
#===========================================================================================
# 2D density plots (1)
#===========================================================================================
# When plotting a single variable, the density plots (and their bandwidths) are calculated
# separate for each variable. However, when you combine many variables together 
# (such as eating habits) it is more useful to see the density of each subset in relation 
# to the whole. For this you need to weight the density plots so that they are relative
# to each other.

# Base layers
p <- ggplot(faithful, aes(x = waiting, y = eruptions)) +
  scale_y_continuous(limits = c(1, 5.5), expand = c(0, 0)) +
  scale_x_continuous(limits = c(40, 100), expand = c(0, 0)) +
  coord_fixed(60 / 4.5)

# Use geom_density_2d()
p + geom_density_2d(h = c(5,0.5))

# Use stat_density_2d()
# Change the color of the lines to the density level they represent:
# specify aes(col = ..level..) inside stat_density_2d().
p + stat_density_2d(h = c(5,0.5), aes(col = ..level..))
#===========================================================================================
# 2D density plots (2)
#===========================================================================================
# the viridis package contains multi-hue color palettes suitable for continuous variables.

# The advantage of these scales is that instead of providing an even color gradient
# for a continuous scale, they highlight the highest values by using an uneven color gradient 
# on purpose. The high values are lighter colors (yellow versus blue), so they stand out more.

# Load in the viridis package
library(viridis)

# Add viridis color scale
ggplot(faithful, aes(x = waiting, y = eruptions)) +
  scale_y_continuous(limits = c(1, 5.5), expand = c(0,0)) +
  scale_x_continuous(limits = c(40, 100), expand = c(0,0)) +
  coord_fixed(60/4.5) +
  stat_density_2d(geom = "tile", aes(fill = ..density..), h=c(5,.5), contour = FALSE)+
  scale_fill_viridis()



