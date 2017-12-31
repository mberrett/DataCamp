#================================================================================
# ggplot 2, course 2: Chapter 1 
#================================================================================
pacman::p_load(ggplot2, dplyr, tidyr,RColorBrewer, car, Hmisc)

# VIDEO 2: STATS OUTSIDE GEOMS

# Basic Plot
ggplot(iris, aes(x = Species, y = Sepal.Length)) +
  geom_point(position = position_jitter(0.2))

# Calculating statistic
set.seed(123)
xx <- rnorm(100)
mean(xx)
mean(xx) + (sd(xx)* c(-1,1))
library(Hmisc)
smean.sdl(xx, mult = 1) # mean +/- stdev 
  # mult = 1 to return one stdev rather than upper and lower bound

# Calculating statistics
# Hmisc
smean.sdl(xx, mult = 1)

#ggplot2
mean_sdl(xx, mult = 1)

# stat_summary()
ggplot(iris, aes(x = Species, y = Sepal.Length)) +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1))
  # geom_pointrange() by default

# more traditional error bar plot
ggplot(iris, aes(x = Species, y = Sepal.Length)) +
  stat_summary(fun.y = mean, geom = "point")+
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1),
               geom = "errorbar", width = 0.1)

# could have made bar plot [NOT RECOMMENDED]
ggplot(iris, aes(x = Species, y = Sepal.Length)) +
  stat_summary(fun.y = mean, geom = "bar", fill = "skyblue")+
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1),
               geom = "errorbar", width = 0.1)

# 95% Confidence Interval

ERR <- qt(0.975, length(xx) - 1) * (sd(xx) / sqrt(length(xx)))
mean(xx) + (ERR* c(1, -1))

# Hmisc
smean.cl.normal(xx)

# ggplot2
mean_cl_normal(xx)

# stat_summary()
ggplot(iris, aes(x = Species, y = Sepal.Length)) +
  stat_summary(fun.data = mean_cl_normal, width = 0.1)
  # Use any function as long as output has expected format 

# Other stat_funtions

  # stat_           | description
  # stat_summary()  | summarise y values from a function of values
  # stat_function() | Computer y values from a function of x values
  # stat_qq()       | Perform calculations for a quantile-quantile plot

# MASS:mammals
# Normal Distribution 
library(MASS)
mam.new <- data.frame(body = log10(mammals$body))
ggplot(mam.new, aes(x = body)) +
  geom_histogram(aes( y = ..density..)) +
  geom_rug() +
  stat_function(fun = dnorm, col = "red",
                args = list(mean = mean(mam.new$body),
                           sd = sd(mam.new$body)))

# QQplot
mam.new$slope <- diff(quantile(mam.new$body, c(0.25, 0.75))) /
                      diff(qnorm(c(0.25,0.75)))
mam.new$int <- quantile(mam.new$body, 0.25) -
                        mam.new$slope * qnorm(0.25)

ggplot(mam.new, aes(sample = body)) +
  stat_qq() +
  geom_abline(aes(slope = slope, intercept = int), col = "red")
#================================================================================
# Preparations
#================================================================================
# Display structure of mtcars
str(mtcars)

# Convert cyl and am to factors:
mtcars$cyl <- factor(mtcars$cyl)
mtcars$am <- factor(mtcars$am)

# Define positions:
posn.d <- position_dodge(width = 0.1)
posn.jd <- position_jitterdodge(jitter.width = 0.1, dodge.width = 0.2)
posn.j <- position_jitter(0.2)

# base layers:
wt.cyl.am <- ggplot(mtcars, aes(x = cyl, y = wt, col = am, fill = am, group = am))

#================================================================================
# Plotting variations
#================================================================================
# Plot 1: Jittered, dodged scatter plot with transparent points
wt.cyl.am +
  geom_point(position = posn.jd, alpha = 0.6)

# Plot 2: Mean and SD - the easy way
wt.cyl.am +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), position = posn.d)

# Plot 3: Mean and 95% CI - the easy way
wt.cyl.am +
  stat_summary(fun.data = mean_cl_normal, position = posn.d)

# Plot 4: Mean and SD - with T-tipped error bars - fill in ___
wt.cyl.am +
  stat_summary(geom = "point", fun.y = mean, 
               position = posn.d) +
  stat_summary(geom = "errorbar", fun.data = mean_sdl, 
               position = posn.d, fun.args = list(mult = 1), width = 0.1)

#================================================================================
# Custom Functions
#================================================================================
xx <- 1:100
# Function to save range for use in ggplot 
gg_range <- function(x) {
  # Change x below to return the instructed values
  data.frame(ymin = min(x), # Min
             ymax = max(x)) # Max
}

gg_range(xx)
# Required output:
#   ymin ymax
# 1    1  100

# Function to Custom function:
med_IQR <- function(x) {
  # Change x below to return the instructed values
  data.frame(y = median(x), # Median
             ymin = quantile(x)[2], # 1st quartile
             
             ymax = quantile(x)[4])  # 3rd quartile
}

med_IQR(xx)
# Required output:
#        y  ymin  ymax
# 25% 50.5 25.75 75.25
#================================================================================
# Custom Functions(2)
#================================================================================
# The base ggplot command, you don't have to change this
wt.cyl.am <- ggplot(mtcars, aes(x = cyl,y = wt, col = am, fill = am, group = am))

# Add three stat_summary calls to wt.cyl.am
wt.cyl.am + 
  stat_summary(geom = "linerange", fun.data = med_IQR, 
               position = posn.d, size = 3) +
  stat_summary(geom = "linerange", fun.data = gg_range, 
               position = posn.d, size = 3, 
               alpha = 0.4) +
  stat_summary(geom = "point", fun.y = median, 
               position = posn.d, size = 3, 
               col = "black", shape = "X")
