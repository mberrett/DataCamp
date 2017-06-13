#================================================================================
# ggplot: Chapter 4 : Geometries: Scatter Plots
#================================================================================
# VIDEO 1: Scatter Plots
library(ggplot2)

# Add layers

# mean result for every column by species 
iris.summary <- aggregate(iris[1:4], list(iris$Species), mean)
names(iris.summary)[1] <- "Species"  


# Two geom layers
ggplot(iris, aes(Sepal.Length, Sepal.Width, col = Species))+
  geom_point()+
  geom_point(data = iris.summary, shape = 15, size = 5)

# Fill in shape ~ pch 21:25
ggplot(iris, aes(Sepal.Length, Sepal.Width, col = Species))+
  geom_point()+
  geom_point(data = iris.summary, shape = 21, size = 5, fill = "#00000080")

# Crosshairs : color scheme doesn't get imported 
ggplot(iris, aes(Sepal.Length, Sepal.Width, col = Species))+
  geom_point()+
  geom_vline(data = iris.summary, aes(xintercept = Sepal.Length))+ #vertical line
  geom_hline(data = iris.summary, aes(yintercept = Sepal.Width)) #horizontal line

# Crosshairs : add color scheme
ggplot(iris, aes(Sepal.Length, Sepal.Width, col = Species))+
  geom_point()+
  geom_vline(data = iris.summary, linetype = 2,
             aes(xintercept = Sepal.Length, col = Species))+ #vertical line
  geom_hline(data = iris.summary, linetype = 2,
             aes(yintercept = Sepal.Width, col = Species)) #horizontal line
  
# Jitter
ggplot(iris, aes(Sepal.Length, Sepal.Width, col = Species))+
  geom_jitter(alpha = 0.6) # alpa blending deals with overplotting of points
                           # helps with regions of high density 

#Jitter plus shape and 
ggplot(iris, aes(Sepal.Length, Sepal.Width, col = Species))+
  geom_jitter(shape = 1) # hollow circle also helps with visual communication for density 

# Example of what alpha can do for overlpotting: compare the following two

#No alpha
ggplot(diamonds, aes(carat, price))+
  geom_jitter()

#Yes alpha
ggplot(diamonds, aes(carat, price))+
  geom_jitter(alpha = 0.1)

# Alpha size shape attack
ggplot(diamonds, aes(carat, price))+
  geom_jitter(alpha = 0.1, size = 4, shape =  ".")

#================================================================================
#Scatter plots and jittering (1)

# The dataset mtcars is available for you

# Plot the cyl on the x-axis and wt on the y-axis
ggplot(mtcars, aes(cyl, wt))+
  geom_point()

# Use geom_jitter() instead of geom_point()
ggplot(mtcars, aes(cyl, wt))+
  geom_jitter()

# Define the position object using position_jitter(): posn.j
posn.j <- position_jitter(0.1)

# Use posn.j in geom_point()
ggplot(mtcars, aes(cyl, wt))+
  geom_point(position = posn.j)

#================================================================================
#Scatter plots and jittering (2)
library(car) #contains Voca Data Se

# Examine the structure of Vocab
str(Vocab)

# Basic scatter plot of vocabulary (y) against education (x). Use geom_point()
ggplot(Vocab, aes(education, vocabulary))+
  geom_point()

# Use geom_jitter() instead of geom_point()
ggplot(Vocab, aes(education, vocabulary))+
  geom_jitter()

# Using the above plotting command, set alpha to a very low 0.2
ggplot(Vocab, aes(education, vocabulary))+
  geom_jitter(alpha = 0.2)

# Using the above plotting command, set the shape to 1
ggplot(Vocab, aes(education, vocabulary))+
  geom_jitter(alpha = 0.2, shape = 1)


