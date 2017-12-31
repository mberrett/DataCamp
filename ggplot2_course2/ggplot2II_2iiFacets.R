#================================================================================
# ggplot 2 II: Chapter 2
#================================================================================
# Facets 
  # Straight-forward yet useful
  # Concept of Small Multiples
    # Edward Tufte
    # Visualization of Quantitative Information, 1983 

# Separate large complex plot into different 
#================================================================================
# Add column with unique ids (don't need to change)
iris$Flower <- 1:nrow(iris)

iris.wide <- iris %>%
  gather(key, value, -Flower, -Species) %>%
  separate(key, c("Part", "Measure"), "\\.") %>%
  spread(Measure, value)

pacman::p_load('RColorBrewer')
p <- ggplot(iris.wide, aes(Length, Width, col = Part)) +
  geom_point(position = position_jitter(), alpha = 0.7) +
  scale_color_brewer(palette = "Set1")

p + facet_grid(.~Species) # rows ~ columns 

#================================================================================
iris.tidy <- iris %>%
  gather(key, Value, -Species) %>%
  separate(key, c("Part", "Measure"), "\\.")

iris$Flower <- NULL #in case Flower is part of the data set 

ggplot(iris.tidy, aes(x = Measure, y = Value, col = Part)) +
  geom_jitter() + #jitter moves it around so you can see the points
  facet_grid(.~Species) # split across columns 

# Other options
  # Split according to rows and columns
  # Wrap subplots in into columns 
#================================================================================
# Facets: the basics
#================================================================================
# Basic scatter plot:
p <- ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point()

# Separate rows according to transmission type, am
p + facet_grid(am~.)

# Separate columns according to cylinders, cyl
p + facet_grid(.~cyl)

# Separate by both columns and rows 
p + facet_grid(am~cyl)

#================================================================================
# Many variables
#================================================================================
# Code to create the cyl_am col and myCol vector
mtcars$cyl_am <- paste(mtcars$cyl, mtcars$am, sep = "_")
myCol <- rbind(brewer.pal(9, "Blues")[c(3,6,8)],
               brewer.pal(9, "Reds")[c(3,6,8)])

# Basic scatter plot, add color scale:
ggplot(mtcars, aes(x = wt, y = mpg, 
                   col = cyl_am)) +
  geom_point() +
  scale_color_manual(values = myCol)

# Facet according on rows and columns.
ggplot(mtcars, aes(x = wt, y = mpg, 
                   col = cyl_am)) +
  geom_point() +
  scale_color_manual(values = myCol)+
  facet_grid(gear~vs)

# Add more variables
ggplot(mtcars, aes(x = wt, y = mpg, 
                   col = cyl_am, size = disp)) +
  geom_point() +
  scale_color_manual(values = myCol)+
  facet_grid(gear~vs)
#================================================================================
# Dropping levels
#================================================================================
# mamsleep is tidyr'd msleep data set

#vore                           name sleep time
#1      omni                     Owl monkey total 17.0
#2     herbi                Mountain beaver total 14.4
#3      omni     Greater short-tailed shrew total 14.9
#4     herbi                            Cow total  4.0
#5     herbi               Three-toed sloth total 14.4
#6     carni              Northern fur seal total  8.7

library(dplyr)

mamsleep <- msleep %>%
  select(vore, name, sleep_total,sleep_rem) %>%
  gather(key, value, -name, -vore) %>%
  separate(key, c("delete","sleep"),"\\_") %>%
  select(vore,name,sleep,value) %>%
  setNames(c("vore","name","sleep","time"))

head(mamsleep)

# Basic scatter plot
ggplot(mamsleep, aes(time,name,col=sleep))+
  geom_point()

# Facet rows accoding to vore
ggplot(mamsleep, aes(time,name,col=sleep))+
  geom_point()+
  facet_grid(vore~.)

# Specify scale and space arguments to free up rows
ggplot(mamsleep, aes(time,name,col=sleep))+
  geom_point()+
  facet_grid(vore~., scale = "free_y",
             space = "free_y")
