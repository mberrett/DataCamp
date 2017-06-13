#================================================================================
# ggplot: Chapter 3 : Aesthetics 
#================================================================================
# VIDEO 1
library(ggplot2)

# mapping
ggplot(iris, aes(Sepal.Length, Sepal.Width)) + 
  geom_point()

# attribute 
ggplot(iris, aes(Sepal.Length, Sepal.Width)) + 
  geom_point(col = "red") # visual attribute 

# mapping onto color -- data frame column mapped onto visible aesthetic 
ggplot(iris, aes(Sepal.Length, Sepal.Width,
       color = Species)) + # color defined by Species 
  geom_point() # 

# aesthetics are called in aes()
# whereas attributes are called in geom_point()

# mapping onto color(2) -- in genereal we only do this when combining two different data frames
ggplot(iris) + 
  geom_point(aes(Sepal.Length, Sepal.Width,
                 color = Species)) 

# Aesthetic   Type
# x           x axis position
# y           y axis position
# colour      Color of dots, outlines of other shapes
# fill        fill color
# size        Diameter of points, thickness of lines
# alpha       Transparency
# linetype    Line dash pattern
# labels      Text on a plot or axes
# shape       Shape 

#=================================================================
# All about aesthetics, part 1

#Map cyl to y
ggplot(mtcars, aes(mpg, cyl)) +
  geom_point()

# Map cyl to x
ggplot(mtcars, aes(cyl, mpg)) +
  geom_point()

# Map cyl to col
ggplot(mtcars, aes(wt, mpg, col = cyl)) + 
  geom_point()

# Map cyl to col
ggplot(mtcars, aes(wt, mpg, col = as.factor(cyl))) + # as.factor makes sure the colors are distinct
  geom_point()

#alternatively
mtcars$cyl <- as.factor(mtcars$cyl)

# Change shape and size of the points in the above plot
ggplot(mtcars, aes(wt, mpg, col = cyl)) +
  geom_point(shape = 1, size = 4)


#=================================================================
# All about aesthetics, part 2

# Map cyl to fill
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point()


# Change shape, size and alpha of the points in the above plot
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point(shape = 16, size = 6, alpha = 0.6)

# mapping a categorical variable onto fill doesn't change the colors, although a legend is generated! 
# Use fill when you have another shape (such as a bar), or when using a point that does have a fill
# and a color attribute, such as shape = 21, which is a circle with an outline. 

ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point(shape = 21, size = 6, alpha = 0.6)

# Any time you use a solid color, make sure to use alpha blending to account for over plotting.

#=================================================================
# All about aesthetics, part 3
mtcars$cyl <- as.factor(mtcars$cyl)

# Map cyl to size
ggplot(mtcars, aes(wt, mpg, size = cyl)) +
  geom_point()


# Map cyl to alpha
ggplot(mtcars, aes(wt, mpg, alpha = cyl)) +
  geom_point()

# Map cyl to shape 
ggplot(mtcars, aes(wt, mpg, shape = cyl)) +
  geom_point()


# Map cyl to labels
# In order to correctly show the labels, use geom_text() instead of geom_point().
ggplot(mtcars, aes(wt, mpg, label = cyl)) +
  geom_text()

#=================================================================
# All about attributes, part 1
mtcars$cyl <- as.factor(mtcars$cyl)

# Define a hexadecimal color
my_color <- "#123456"

# Set the color aesthetic 
ggplot(mtcars, aes(wt,mpg, col = cyl)) +
  geom_point()

# Set the color aesthetic and attribute 
ggplot(mtcars, aes(wt,mpg, col = cyl)) +
  geom_point(col = my_color)


# Set the fill aesthetic and color, size and shape attributes
ggplot(mtcars, aes(wt,mpg, fill = cyl)) +
  geom_point(col = my_color, size = 10, shape = 23)

#=================================================================
# All about attributes, part 2

# Expand to draw points with alpha 0.5
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point(alpha = 0.5)

# Expand to draw points with shape 24 and color yellow
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point(shape = 24, col = "yellow")

# Expand to draw text with label x, color red and size 10
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_text(label = "x", col = "red", size = 10)

#=================================================================
# All about attributes, part 2
mtcars$cyl <- as.numeric(mtcars$cyl)

# Map mpg onto x, qsec onto y and factor(cyl) onto col
ggplot(mtcars, aes(mpg, qsec, col = factor(cyl))) +
  geom_point()


# Add mapping: factor(am) onto shape
ggplot(mtcars, aes(mpg, qsec, col = factor(cyl), 
                   shape = factor(am))) +
  geom_point()


# Add mapping: (hp/wt) onto size
ggplot(mtcars, aes(mpg, qsec, col = factor(cyl), 
                   shape = factor(am), size = (hp/wt))) +
  geom_point()

#label and shape are only applicabel to categoricaol variables 

