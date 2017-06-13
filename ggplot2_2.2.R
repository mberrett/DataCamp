#================================================================================
# ggplot 2: Chapter 2
#================================================================================
# VIDEO 3: Proper Data Format 
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
