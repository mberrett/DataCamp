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
#================================================================================
# ggplot: Chapter 3 : Aesthetics 
#================================================================================
# VIDEO 2: Identity
  
# Default
ggplot(iris, aes(Sepal.Length, Sepal.Width, col = Species))+
  geom_point(position = "identity")

# Position Jitter -- random noise for clarity
ggplot(iris, aes(Sepal.Length, Sepal.Width, col = Species))+
  geom_point(position = "jitter")

# Position Jitter(2) -- consistency in jitter across plots 
pos.j <- position_jitter(width = 0.1)
ggplot(iris, aes(Sepal.Length, Sepal.Width, col = Species))+
  geom_point(position = pos.j)

# Scale Functions

#scale_which aesthetic_what kind of data (must match)

# scale_x_continuous
# scale_y...
# scale_color_discrete
# scale_fill...
# scale_color...
# scale_shape...
# scale_linetype...

ggplot(iris, aes(Sepal.Length, Sepal.Width, col = Species)) +
  geom_point(position = "jitter") +
  scale_x_continuous("Sepal Length", limits = c(2,8), # limits of scale, breaks in the guide
                     breaks = seq(2,8,3), expand = c(0,0)) + # expand range of the scales 
  scale_color_discrete("Species",
                       labels = c("Setosa", "Versicolor", "Virginica")) #adjust label names

ggplot(iris, aes(Sepal.Length, Sepal.Width, col = Species)) +
  geom_point(position = "jitter") +
labs(x = "Sepal Length", y = "Sepal Width", col = "Species") #for quick changes to axes labels 

#================================================================
# Position
cyl.am <- ggplot(mtcars, aes(x = factor(cyl), fill = factor(am)))

# The base layer, cyl.am, is available for you
# Add geom (position = "stack" by default)
cyl.am + 
  geom_bar(position = "stack")

# Fill - show proportion
cyl.am + 
  geom_bar(position = "fill")  

# Dodging - principles of similarity and proximity
cyl.am +
  geom_bar(position = "dodge") 

# Clean up the axes with scale_ functions
val = c("#E41A1C", "#377EB8")
lab = c("Manual", "Automatic")
cyl.am +
  geom_bar(position = "dodge") +
  scale_x_discrete("Cylinders") + 
  scale_y_continuous("Number") +
  scale_fill_manual("Transmission", 
                    values = val,
                    labels = lab) 



#================================================================
# Setting a dummy aesthetic 

# Add a new column called group
mtcars$group <- 0

# Create jittered plot of mtcars: mpg onto x, group onto y
ggplot(mtcars, aes(mpg,group))+
  geom_jitter()

# Change the y aesthetic limits
ggplot(mtcars, aes(mpg,group))+
  geom_jitter()+
  scale_y_continuous(limits = c(-2,2))


#================================================================
# VIDEO 3: Aesthetics Best Practices

# color ain't great for contnuous variables
# avoid unecessary noise


#================================================================
# Overplotting 1 - Point shape and transparency

# Basic scatter plot: wt on x-axis and mpg on y-axis; map cyl to col
ggplot(mtcars, aes(wt,mpg,col = cyl)) +
  geom_point(size = 4)

# Hollow circles - an improvement
ggplot(mtcars, aes(wt,mpg,col = cyl)) +
  geom_point(size = 4, shape = 1)

# Add transparency - very nice
ggplot(mtcars, aes(wt,mpg,col = cyl)) +
  geom_point(size = 4, shape = 1, alpha = 0.6)


#================================================================
#Overplotting 2 - alpha with large datasets

# Scatter plot: carat (x), price (y), clarity (col)
ggplot(diamonds, aes(carat, price, col = clarity)) +
  geom_point()

# Adjust for overplotting
ggplot(diamonds, aes(carat, price, col = clarity)) +
  geom_point(alpha = 0.5)


# Scatter plot: clarity (x), carat (y), price (col)
ggplot(diamonds, aes(clarity, carat, col = price))+
  geom_point(alpha = 0.5)


# Dot plot with jittering
ggplot(diamonds, aes(clarity, carat, col = price))+
  geom_point(alpha = 0.5, position = "jitter")


