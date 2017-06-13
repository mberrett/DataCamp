#================================================================================
# ggplot: Chapter 4 : Geometries: Bar Plots
#================================================================================
# VIDEO 1: Bar Plots
library(ggplot2)
library(datasets)
library(MASS)
#================================================================================
# Histogram: doesn't plot data, plots bins 
ggplot(iris, aes(Sepal.Width))+ # specify a single aesthetic x
  geom_histogram(col = "white", binwidth = 0.1) # col for border, binwidth for bins 
  # range/30 = 0.08 default binwidth
  # x axis shows intervals not actual values, y axis shows absolute count of each bin
  # what portion of the total is represented in each bin? Frequency or Density 
  # no space between bars to emphasize that this is a representation of an underlying continous dist

# Denisty : Nothing changes except y label 
ggplot(iris, aes(Sepal.Width))+ # 
  geom_histogram(col = "white", binwidth = 0.1,aes(y =  ..density..))
                                                  # .. .. tell R it's internal data
# stack 
ggplot(iris, aes(Sepal.Width, fill = Species))+ # use fill aesthetic because dealing with shapes 
  geom_histogram(binwidth = 0.1, position = "stack") # stack is default 

# dodge 
ggplot(iris, aes(Sepal.Width, fill = Species))+ # use fill aesthetic because dealing with shapes 
  geom_histogram(binwidth = 0.1, position = "dodge") # offsets each data point 

# dodge 
ggplot(iris, aes(Sepal.Width, fill = Species))+ # use fill aesthetic because dealing with shapes 
  geom_histogram(binwidth = 0.1, position = "fill")+ # normalizes each bin to represent 
  ylab("proportion")                                 # a proportion of all observations in each bin 

#================================================================================
# Bar Plot: absolute counts or distributions
ggplot(msleep, aes(vore))+
  geom_bar(stat = "count") # default

# NONE OF THIS STUFF WORKED SO I MADE IT MYSELF
#================================================================================
detach("package:dplyr", unload = T)
library(reshape)
library(plyr)
iris_melted <- melt(iris, value.name = "Value",
                    variable.name = "Measure")
head(iris$Species)
head(iris_melted)
iris_summ <- ddply(iris_melted[iris_melted$Measure == "Sepal.Width",],
                   "Species", summarize(), avg = mean(Value),
                   stdev = sd(Value))
str(iris_summ)
#================================================================================
# NONE OF THIS^ STUFF WORKED SO I MADE IT MYSELF

iris_summ2 <- data.frame(Species = rbind("setosa", "versicolor","virginica"), avg = c(3.43, 2.77,2.97), 
                         stdev = c(0.379,0.314,0.322))

str(iris_summ2)

ggplot(iris_summ2, aes(x= Species , y = avg))+
  geom_bar(stat = "identity", fill = "grey50")+
  geom_errorbar(aes(ymin = avg - stdev, ymax = avg + stdev),
                width = 0.2)

# DINAMITE PLOTS : STRONGLY DISCOURAGED FOR VARIOUS REASONS 


#================================================================================
# Histograms 

# Make a univariate histogram
ggplot(mtcars, aes(x = mpg))+
  geom_histogram()

# Change the bin width to 1
ggplot(mtcars, aes(x = mpg))+
  geom_histogram(binwidth = 1)

# Change the y aesthetic to density
ggplot(mtcars, aes(mpg))+
  geom_histogram(binwidth = 1, 
                 aes(y = ..density..))

# Custom color code
myBlue <- "#377EB8"

# Change the fill color to myBlue
ggplot(mtcars, aes(mpg))+
  geom_histogram(binwidth = 1,
                 aes(y = ..density..,
                     fill = "#377EB8"))

#================================================================================
# 2) Position
mtcars$am <- factor(mtcars$am) 
# Draw a bar plot of cyl, filled according to am
ggplot(mtcars, aes(x= cyl, fill = am))+
  geom_bar()

# Change the position argument to stack
ggplot(mtcars, aes(cyl, fill = am))+
  geom_bar(position = "stack")

# Change the position argument to fill
ggplot(mtcars, aes(cyl, fill = am))+
  geom_bar(position = "fill")

# Change the position argument to dodge
ggplot(mtcars, aes(cyl, fill = am))+
  geom_bar(position = "dodge")

#================================================================================
# 3) Overlapping barplots 
# Draw a bar plot of cyl, filled according to am
ggplot(mtcars, aes(cyl, fill = am))+
  geom_bar()

# Change the position argument to "dodge"
ggplot(mtcars, aes(cyl, fill = am))+
  geom_bar(position = "dodge")

# Define posn_d with position_dodge()
posn_d <- position_dodge(0.2)

# Change the position argument to posn_d
ggplot(mtcars, aes(cyl, fill = am))+
  geom_bar(position = posn_d)

# Use posn_d as position and adjust alpha to 0.6

ggplot(mtcars, aes(cyl, fill = am))+
  geom_bar(position = posn_d, aes(alpha = 0.6))


#================================================================================
# 3) Overlapping histograms
mtcars$cyl <- factor(mtcars$cyl)

# A basic histogram, add coloring defined by cyl 
ggplot(mtcars, aes(mpg, fill = cyl)) +
  geom_histogram(binwidth = 1)

# Change position to identity 
ggplot(mtcars, aes(mpg, fill = cyl)) +
  geom_histogram(binwidth = 1, 
                 position = "identity")

# Change geom to freqpoly (position is identity by default) 
ggplot(mtcars, aes(mpg, col = cyl)) +
  geom_freqpoly(binwidth = 1)

#================================================================================
# 4) Bar plots with color ramp, part 1
library(car)
# Example of how to use a brewed color palette
ggplot(mtcars, aes(x = cyl, fill = am)) +
  geom_bar() +
  scale_fill_brewer(palette = "Set1")

# Use str() on Vocab to check out the structure
str(Vocab)

# Plot education on x and vocabulary on fill
Vocab$vocabulary <- factor(Vocab$vocabulary)
# Use the default brewed color palette
ggplot(Vocab, aes(x = education, 
                  fill = vocabulary)) +
  geom_bar(position = "fill") +
  scale_fill_brewer()

#================================================================================
# 4) Bar plots with color ramp, part 2
#In the previous exercise, we ended up with an incomplete bar plot. 
#The default brewer function, scale_fill_brewer(), didn't generate enough blue values.

#In this exercise, you'll manually create a color brewer 
# that can generate enough blue values to fill up the bars for all values.
library(RColorBrewer)

# Definition of a set of blue colors
blues <- brewer.pal(9, "Blues")

# Make a color range using colorRampPalette() and the set of blues
blue_range <- colorRampPalette(blues)

# Use blue_range to adjust the color of the bars, use scale_fill_manual()
ggplot(Vocab, aes(x = education, 
                  fill = vocabulary)) +
  geom_bar(position = "fill") +
  scale_fill_manual(values  = blue_range(11))

#The default color palette is "Blues". Since we have 11 categories 
# but there are only 9 colors in this palette, our plot looked strange. 

# To adjust the number of colors, we'll use a function, colorRampPalette(), 
# to define a better color palette ramp. Use this function with blues, 
# a set of blue colors which has been formed for you. 

# Assign it to blue_range. colorRampPalette() generates a function, 
# so when we call our object blue_range, we have to specify the number of colors 
# we want from the range of values.
#================================================================================
# 5) Overlapping histograms (2)

# Basic histogram plot command
ggplot(mtcars, aes(mpg)) + 
  geom_histogram(binwidth = 1)

# Expand the histogram to fill using am
ggplot(mtcars, aes(mpg, fill = am)) + 
  geom_histogram(binwidth = 1)

# Change the position argument to "dodge"
ggplot(mtcars, aes(mpg, fill = am)) + 
  geom_histogram(binwidth = 1, 
                 position = "dodge")

# Change the position argument to "fill"
ggplot(mtcars, aes(mpg, fill = am)) + 
  geom_histogram(binwidth = 1, 
                 position = "fill")

# Change the position argument to "identity" and set alpha to 0.4
ggplot(mtcars, aes(mpg, fill = am)) + 
  geom_histogram(binwidth = 1, 
                 position = "identity", alpha = 0.4)

# Change fill to cyl
ggplot(mtcars, aes(mpg, fill = cyl)) + 
  geom_histogram(binwidth = 1, 
                 position = "identity", alpha = 0.4)



