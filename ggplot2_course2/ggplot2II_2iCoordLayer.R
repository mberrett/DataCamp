#================================================================================
# ggplot 2 II: Chapter 2
#================================================================================
# Coordinates Layer
  # Controls plot dimensions
  # coord_
  # coord_cartesian

# Zooming in
  # scale_x_continuous(limits = ...)
  # xlim()
  # coord_cartesian
pacman::p_load(ggplot2)
iris.smooth <- ggplot(iris, aes(x = Sepal.Length,
                                y = Sepal.Width,
                                col = Species)) +
  geom_point(alpha = 0.7) + geom_smooth()
iris.smooth

# scale_x_continous
  # only one blue point so virginica line disappears
iris.smooth + scale_x_continuous(limits = c(4.5,5.5))

# x lime (not as flexible)
iris.smooth + xlim(c(4.5,5.5))

# coord_cartesian
iris.smooth <- coord_cartesian(xlim = c(4.5,5.5))

# Aspect Ratio
  # Height-to-width ration
  # Deception!
  # Standardization attempts
  # Typically 1:1

# Sunspots
pacman::p_load('reshape2','zoo')
sunspots.m <- data.frame(year = index(sunspot.month),
                         value = melt(sunspot.month)$value)

ggplot(sunspots.m, aes(year, value)) +
  geom_line() +
  coord_equal()

# Oscillating period in 11 year
# Sunspot numbers change over long periods

ggplot(sunspots.m, aes(year, value)) +
  geom_line() +
  coord_equal(0.055)

# sunspots arise more quickly than they appear
#================================================================================
# Zooming in 
#================================================================================
ggplot(sunspots.m, aes(year, value)) +
  geom_line() +
  coord_equal()

#================================================================================
# Aspect Ratio
#================================================================================
# Complete basic scatter plot function
base.plot <- ggplot(iris, aes(Sepal.Length, Sepal.Width, col = Species)) +
  geom_jitter() +
  geom_smooth(method = "lm", se = F)

# Plot base.plot: default aspect ratio
base.plot

# Fix aspect ratio (1:1) of base.plot
base.plot + coord_equal(1:1)

#================================================================================
# Pie Charts
#================================================================================
# The coord_polar() function converts a planar x-y cartesian plot to polar coordinates. 
# Create stacked bar plot: thin.bar
mtcars$cyl <- factor(mtcars$cyl)
thin.bar <- ggplot(mtcars, aes(x =1, fill=cyl)) +
  geom_bar()

# Convert thin.bar to pie chart
thin.bar + coord_polar(theta  ='y')

# Create stacked bar plot: wide.bar
wide.bar <- ggplot(mtcars, aes(x =1, fill=cyl)) +
  geom_bar(width = 1)

# Convert wide.bar to pie chart
wide.bar + coord_polar(theta = 'y')

# Create a basic stacked bar plot. Since we have univariate data and 
# stat_bin() requires an x aesthetic, we'll have to use a dummy variable. 
# Set x to 1 and map cyl onto fill. Assign the bar plot to thin.bar.

# Add a coord_polar() layer to thin.bar. Set the argument theta to "y". 
# This specified the axis which would be transformed to polar coordinates. 
