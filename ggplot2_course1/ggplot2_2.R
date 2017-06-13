#================================================================================
# ggplot 2: Chapter 2
#================================================================================
library(ggplot2)

#     Data       Aesthetics
ggplot(iris, aes(x=Sepal.Length,
                 y=Sepal.Width)) +
  geom_point()
  #geometry 

    #     Data       Aesthetics
p  <- ggplot(iris, aes(x=Sepal.Length,
                       y=Sepal.Width)) +
         geom_point()
         #geometry 

p # calls the whole plot


#================================================================================
# 1) base package and ggplot2, part 1 - plot

# Plot the correct variables of mtcars
plot(mtcars$wt,mtcars$mpg, col = mtcars$cyl)

# Change cyl inside mtcars to a factor
mtcars$cyl <- as.factor(mtcars$cyl)

# Make the same plot as in the first instruction
plot(mtcars$wt,mtcars$mpg, col = mtcars$cyl)

# Recall that under-the-hood, factors are simply integer type vectors,
# so the colors in the second plot are 1, 2, and 3. 
# In the first plot the colors were 4, 6, and 8.
#================================================================================
# 2) base package and ggplot2, part 2 - lm

# Basic plot
mtcars$cyl <- as.factor(mtcars$cyl)
plot(mtcars$wt, mtcars$mpg, col = mtcars$cyl)

# Use lm() to calculate a linear model and save it as carModel
carModel <- lm(mpg ~ wt, data = mtcars)

# Call abline() with carModel as first argument and set lty to 2
abline(carModel, lty = 2)

# Plot each subset efficiently with lapply
# You don't have to edit this code
lapply(mtcars$cyl, function(x) {
  abline(lm(mpg ~ wt, mtcars, subset = (cyl == x)), col = x)
})

# This code will draw the legend of the plot
# You don't have to edit this code
legend(x = 5, y = 33, legend = levels(mtcars$cyl),
       col = 1:3, pch = 1, bty = "n")

#================================================================================
# base package and ggplot2, part 3

# Convert cyl to factor (don't need to change)
mtcars$cyl <- as.factor(mtcars$cyl)

# Example from base R (don't need to change)
plot(mtcars$wt, mtcars$mpg, col = mtcars$cyl)
abline(lm(mpg ~ wt, data = mtcars), lty = 2)
lapply(mtcars$cyl, function(x) {
  abline(lm(mpg ~ wt, mtcars, subset = (cyl == x)), col = x)
})
legend(x = 5, y = 33, legend = levels(mtcars$cyl),
       col = 1:3, pch = 1, bty = "n")

# Plot 1: add geom_point() to this command to create a scatter plot
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point()  # Fill in using instructions Plot 1

# Plot 2: include the lines of the linear models, per cyl
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point() + # Copy from Plot 1
  geom_smooth(method = lm, se = F)  # Fill in using instructions Plot 2

# Plot 3: include a lm for the entire dataset in its whole
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point() + # Copy from Plot 2
  geom_smooth(method = lm, se = F) + # Copy from Plot 2
  geom_smooth(aes(group = 1), method = lm,
              se = F, linetype = 2)  # Fill in using instructions Plot 3

#================================================================================
# VIDEO 3: Proper Data Format 
#================================================================================
library(ggplot2)

# a) what is possible but completely WRONG
ggplot(iris, aes(Sepal.Length, Sepal.Width))+
  geom_point() +
  geom_point(aes(Petal.Length, Petal.Width), col = "red")

# plotting space is adjugest
# ggplot2 produces an object 

# b) what is RIGHT
#ggplot(iris.wide, aes(x = Length, y = Width, col = Part))+
 # geom_point() 

#================================================================================
# VIDEO 3: Proper Data Format 
library(ggplot2)

# iris.wide2


#================================================================================
# 1) Variables to visuals, part 1b (goes after 1 in tutorial)
# Load the tidyr package
library(tidyr)
iris
# Fill in the ___ to produce to the correct iris.tidy dataset
iris.tidy <- iris %>%
  gather(key, Value, -Species) %>%
  separate(key, c("Part", "Measure"), "\\.")

iris$Flower <- NULL #in case Flower is part of the data set 
#================================================================================
# 2) Variables to visuals, part 1

# Think about which dataset you would use to get the plot shown right
# Fill in the ___ to produce the plot given to the right
ggplot(iris.tidy, aes(x = Species, y = Value, col = Part)) +
  geom_jitter() + #jitter moves it around so you can see the points
  facet_grid(. ~ Measure)

# gather() rearranges the data frame 
# by specifying the columns that are categorical variables with a - notation. 
# Notice that only one variable is categorical in iris.

# separate() splits up the new key column, which contains the former headers, according to "."
# The new column names "Part" and "Measure" are given in a character vector. Don't forget the quotes.

#================================================================================
# 3) Variables to visuals, part 2b (goes after 2 in tutorial)
# Load the tidyr package
library(tidyr)

# Add column with unique ids (don't need to change)
iris$Flower <- 1:nrow(iris)

# Fill in the ___ to produce to the correct iris.wide dataset
iris.wide <- iris %>%
  gather(key, value, -Flower, -Species) %>%
  separate(key, c("Part", "Measure"), "\\.") %>%
  spread(Measure, value)

# The last step is to use spread() to distribute the new Measure column 
# and associated value column onto two columns.

#================================================================================
# 3) Variables to visuals, part 2

# Consider the head of iris, iris.wide and iris.tidy (in that order)
head(iris)
head(iris.wide)
head(iris.tidy)

# Think about which dataset you would use to get the plot shown right
# Fill in the ___ to produce the plot given to the right
ggplot(iris.wide, aes(x = Length, y = Width, col = Part)) +
  geom_jitter() +
  facet_grid(. ~ Species)
