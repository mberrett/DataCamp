#=============================================================
# ggplot2 II, Chapter 4: Best Practices: Pie Charts 
#=============================================================
pacman::p_load(ggplot2, Hmisc, RColorBrewer, dplyr, tidyr)

#...pie chart (and why it sucks)
ggplot(mtcars, aes (x = factor(1), fill = factor(cyl))) +
  geom_bar(width = 1)
ggplot(mtcars, aes (x = factor(1), fill = factor(cyl))) +
  geom_bar(width = 1)
ggplot(mtcars, aes (x = factor(1), fill = factor(cyl))) +
  geom_bar(width = 1) +
  coord_polar(theta = 'y')

# Parts-of-a-whole
  # Circle is a symbol for the whole
  # However, it stops there
str(HairEyeColor)
HEC <- data.frame(HairEyeColor)
str(HEC)

HairCol <- HEC %>%
  select(Hair, Sex, Freq) %>%
  gather(Key, Value, -Sex, -Hair) %>%
  mutate(fillin = Hair)

# Delete extraneous Key column
HairCol$Key <- NULL

# Replace duplicate of Hair column, fillin, with color codes
HairCol$fillin <- as.character(HairCol$fillin)
HairCol$fillin[HairCol$fillin == "Black"] <- "#666666"
HairCol$fillin[HairCol$fillin == "Brown"] <- "#A65628"
HairCol$fillin[HairCol$fillin == "Red"] <- "#E41A1C"
HairCol$fillin[HairCol$fillin == "Blond"] <- "#FFFF33"
HairCol

#=============================================================
ggplot(HairCol, aes(Hair, Value, fill = fillin))+
  geom_bar(stat = "identity", position = "dodge")+
  facet_grid(.~Sex) +
  scale_fill_identity()+
  theme_classic()
# not finished
  # haven't figured out npropr or n columns yet
#=============================================================
# angle, area, length
# mediocre elements
  
# Pie charts may only be suitable for comparing quantities
  # between at least three gorups

# What's the alternative?

# Don't convert to coord_polar
ggplot(mtcars, aes (x = factor(1), fill = factor(cyl))) +
  geom_bar(width = 1) +
  coord_flip()

#=============================================================
# Pie Charts (1)
#=============================================================
# Convert bar chart to pie chart
mtcars$am <- factor(mtcars$am)

ggplot(mtcars, aes(x = factor(1), fill = am)) +
  geom_bar(position = "fill", width = 1)+
  facet_grid(.~cyl) +
  coord_polar(theta = "y")
#=============================================================
# Pie Charts (2)
#=============================================================
# Parallel coordinates plot using GGally
pacman::p_load(GGally)
names(mtcars)

# All columns except am
mtcars$am <- factor(mtcars$am)
group_by_am <- 9
my_names_am <- (1:11)[-group_by_am]

# Basic parallel plot - each variable plotted as a z-score transformation
ggparcoord(mtcars, my_names_am, groupColumn = group_by_am, alpha = 0.8)
#=============================================================
# Pie Matrix (1)
#=============================================================
# Watch out takes forever to load
mtcars2 <- select(mtcars, mpg, disp, drat, wt, qsec)
GGally::ggpairs(mtcars2) # uncomment to run 

# Q: What is the relationship between drat and mpg?
# A: Correlation of 0.681
#=============================================================
# Pie Matrix (2)
#=============================================================
# Watch out takes forever to load
mtcars3 <- select(mtcars, mpg, cyl, disp, hp, drat)
mtcars3$cyl <- factor(mtcars3$cyl)
GGally::ggpairs(mtcars3) # uncomment to run 

# Q: What is the relationship between disp and cyl?
# A: As cyl increases, so to does the disp