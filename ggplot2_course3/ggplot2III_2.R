#===========================================================================================
# ggplot2 III: Chapter 3: Specialized Plots
#===========================================================================================
# VIDEO: Graphics of Large Data
#===========================================================================================
# Defining largeness
# o Many observations
  # o High-resolutions
  # o Large surveys
  # o Website analytics
# o Many variables
  # o Multidimensional data
# o Combination

# Many observations
dim(diamonds)
head(diamonds)

# Scatter plot
library(ggplot2)
ggplot(diamonds, aes(carat, price))+
  geom_point(col = "dark red") # simplified

# Adjust symbol, opacity + 2d density
ggplot(diamonds, aes(carat, price))+
  geom_point(col = "dark red", shape = 16, alpha = 0.2)+
  stat_density2d(col = "blue")

# 2D density (2)
ggplot(diamonds, aes(carat, price))+
  geom_point(col = "dark red", shape = 16, alpha = 0.2)+
  stat_density2d(aes(color = ..level..))

# 2D density (3)
ggplot(diamonds, aes(carat, price))+
  stat_density2d(geom = "tile",
                 aes(fill = ..density..),
                 contour = F)

# Binning (1)
ggplot(diamonds, aes(carat, price))+
  geom_bin2d()

# Binning (2)
ggplot(diamonds, aes(carat, price))+
  geom_bin2d(bins = 100) # increasse or decrease resolution with bins

# Hex-binning (1)
ggplot(diamonds, aes(carat, price))+
  geom_bin2d()

# Hex-binning (1)
ggplot(diamonds, aes(carat, price))+
  geom_bin2d(bins = 100)

# Many observations
# o Reducing over-plotting
# o Reducing amount of information that is plotted
# o Aggregates

# Many variables
# o Multi-variate or high dimensional data
# o Data reduction methods
# o Previously: facets
# o Two plot types

# SPLOM - Scatter PLOt Matrix
pairs(iris[-5])

# Correlation matrix 
library(PerformanceAnalytics)
chart.Correlation(iris[-5])

# ggAlly::ggpairs()
library(GGally)
ggpairs(mtcars) 
# can handle categorical data

# Parallel coordinate plot
ggparcoord(iris, columns = 1:4,
           groupColumn = 5,
           scale = "globalminmax",
           order = "anyClass",
           alphaLines = 0.4)



#===========================================================================================
# Pair plots and correlation matrices
#===========================================================================================
# pairs
pairs(iris[1:4])

# chart.Correlation
library(PerformanceAnalytics)
chart.Correlation(iris[1:4])

# ggpairs
library(GGally)
mtcars$cyl <- as.factor(mtcars$cyl)
ggpairs(mtcars[1:3])

#===========================================================================================
# VIDEO: Graphics of Large Data
#===========================================================================================

