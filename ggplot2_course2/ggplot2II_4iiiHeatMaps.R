#=============================================================
# ggplot2 II, Chapter 4: Best Practices: Heat Maps
#=============================================================
# Video: Didn't contain code for me to replicate
#=============================================================
pacman::p_load(ggplot2, Hmisc, RColorBrewer, dplyr, tidyr)

# barleys
head(barley, 15)
#=============================================================
# Heat Maps 
#=============================================================
# o Define the data and the aesthetics layer.
#   Using the barley dataset, map year onto x, 
#   variety onto y and fill according to yield

# o Add a geom_tile() to build the heat maps.

# o So far the entire dataset it plotted on one heat map. 
#   Add a facet_wrap() function to get a facetted plot.
#   Use the formula ~ site (without the dot!) and set ncol = 1. 
#   By default, the names of the farms will be above the panels, 
#   not to the side.

# o brewer.pal() from the RColorBrewer package has been used 
#   to create a "Reds" color palette. 
#   The hexadecimal color codes are stored in the myColors object. 
#   Add the scale_fill_gradientn() function and specify 
#   the colors argument correctly to give the heat maps a reddish look.

# Create color palette
myColors <- brewer.pal(9, "Reds")

# Build the heat map from scratch
ggplot(barley, aes(x = year, y = variety, fill = yield)) + 
  geom_tile() +
  facet_wrap(~site, ncol = 1) + 
  scale_fill_gradientn(colors = myColors)

#=============================================================
# Heat Maps Alternatives (1)
#=============================================================
# The line plot might be a good alternative:

# o Base layer: same dataset, map year onto x, yield onto y
#   and variety onto col as well as onto group!

# o Add the appropriate geom for this line plot; 
#   no additional arguments are needed.

# o Add facetting with the same formula as in the heat map plot, 
#   instead of ncol, set nrow to 1.

# The heat map we want to replace
# Don't remove, it's here to help you!
myColors <- brewer.pal(9, "Reds")
ggplot(barley, aes(x = year, y = variety, fill = yield)) +
  geom_tile() +
  facet_wrap( ~ site, ncol = 1) +
  scale_fill_gradientn(colors = myColors)

# Line plots
ggplot(barley, aes(x = year, y = yield, col = variety, group = variety)) + geom_line()+
  facet_wrap(~ site, nrow = 1) 

#=============================================================
# Heat Maps Alternatives (2)
#=============================================================
# Create a plot, similar to the one in the viewer, 
# from scratch by following these steps:
  
# o Base layer: use the barley dataset. 
#   Try to come up with the correct mappings for x, y, col, 
#   group and fill.

# o Add a stat_summary() function for the mean. 
#   Specify fun.y to be mean and set geom to "line".

# o Add a stat_summary() function for the ribbons. 
#   Set fun.data = mean_sdl and fun.args = list(mult = 1) 
#   to have a ribbon that spans over one standard deviation 
#   in both directions. 
#   Use the "ribbon" geom. Set col = NA and alpha = 0.1.

str(barley)

# Create overlapping ribbon plot from scratch
ggplot(barley, aes(x = year , y = yield, 
                   col = site, group = site , fill = site)) +
  stat_summary(fun.y = mean, geom = "line")+
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), geom = "ribbon", col = NA,
               alpha = 0.1)+
  theme_classic() +
  ggtitle("Barely Yield over Year by Site")
