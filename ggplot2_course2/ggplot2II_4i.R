#=============================================================
# ggplot2 II, Chapter 4: Best Practices
#=============================================================
pacman::p_load(ggplot2, Hmisc, dplyr, tidyr, RColorBrewer)
# Chapter Contets
  # Common pitfalls
  # Best way to represent data

# Bar plot
  # Two types
    # Absolute values
    # Distribution (incredibly common & equally terrible)

# Dynamite plot 
str(msleep)
d <- ggplot(msleep, aes(factor(vore), sleep_total)) +
  scale_y_continuous("Total sleep time (h)",
                     limits = c(0,24),
                     breaks = seq(0,24,3),
                     expand = c(0,0)) +
  xlab("Eating habits") +
  theme_classic()

d + 
  stat_summary(fun.y = mean, geom = "bar",
               fill = "grey50") +
  stat_summary(fun.data = mean_sdl, 
               fun.args = list(mult = 1), # multi passed thru fun.args and list now
               geom = "errorbar", width = 0.2)

# Issues 
  # How many observations in each category?
  # Suggests data is normally distributed 
    # if it isn't it's unfair to get the impression
    # real data is hidden
  # bars give impression of having data where there is none
    # there are no mammals that sleep 0 hours a day
  # we don't see visualz where there is data 
    # above the mean 

# Individual data points
d + 
  geom_point(alpha = 0.6, position = position_jitter(width = 0.2))
  # alpha set to 0.6 in case of residual overplotting

  # Patterns
    # not that much data about insectivore
      # could be bimodal, but we need more info
      # omnivores seem positively skewed

# errorbar
d +
  geom_point(alpha = 0.6, position = position_jitter(width = 0.2)) +
  stat_summary(fun.y = mean, geom = "point", fill = "red") +
  stat_summary(fun.data = mean_sdl, mult = 1, geom = "errorbar",
               width = 0.2, col = "red")

# pointrange
d + 
  geom_point(alpha = 0.6, position = position_jitter(width = 0.2)) +
  stat_summary(fun.data = mean_sdl, mult = 1, width = 0.2, col = "red")

# without data points 
d +
  stat_summary(fun.y = mean, geom = "point", fill = "red") +
  stat_summary(fun.data = mean_sdl, mult = 1, geom = "errorbar",
               width = 0.2, col = "red")

# Error bars with points are a much cleaner representation of the data
  # the bars are simply not necessary
  # although this data set may not be suitable 



#=============================================================
# Bar Plots (1)
#=============================================================
# Base layers
m <- ggplot(mtcars, aes(x = cyl, y = wt))

# Draw dynamite plot
m +
  stat_summary(fun.y = mean, geom = "bar", fill = "skyblue") +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), 
               geom = "errorbar", width = 0.1)

#=============================================================
# Bar Plots (2)
#=============================================================
mtcars$am <- factor(mtcars$am)
# Base layers
m <- ggplot(mtcars, aes(x = cyl,y = wt, col = am, fill = am))

# Plot 1: Draw dynamite plot
m +
  stat_summary(fun.y = mean, geom = "bar") +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1),
               geom = "errorbar", width = 0.1)

# Plot 2: Set position dodge in each stat function
m +
  stat_summary(fun.y = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), 
               geom = "errorbar", width = 0.1, position = "dodge")

# Set your dodge posn manually
posn.d <- position_dodge(1.9)

# Plot 3:  Redraw dynamite plot
m +
  stat_summary(fun.y = mean, geom = "bar", position = posn.d) +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), 
               geom = "errorbar", width = 0.1, position = posn.d)

#=============================================================
# Bar Plots (3)
#=============================================================
# Using stat_sum() generate the following
# mtcars.cyl summary data frame 

# cyl   wt.avg        sd  n    prop
# 1   4 2.285727 0.5695637 11 0.34375
# 2   6 3.117143 0.3563455  7 0.21875
# 3   8 3.999214 0.7594047 14 0.43750

# Base layers
m <- ggplot(mtcars.cyl, aes(x = cyl, y = wt.avg))

# Plot 1: Draw bar plot
m + geom_bar(stat = "identity", 
             fill = "skyblue")

# Plot 2: Add width aesthetic
m + geom_bar(stat = "identity", 
             fill = "skyblue", aes(width = prop))


# Plot 3: Add error bars
m + geom_bar(stat = "identity", 
             fill = "skyblue", aes(width = prop)) +
  geom_errorbar(aes(ymin = wt.avg - sd, 
                    ymax = wt.avg + sd), width = 0.1)




