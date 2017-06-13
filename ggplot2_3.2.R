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

