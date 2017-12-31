#================================================================================
# ggplot 2, course 2: Chapter 1 
#================================================================================
pacman::p_load(ggplot2, dplyr, tidyr,RColorBrewer, car)

# ggplot2, course 2
  # Statistics
  # Coordinates
  # Facets
  # Themes
  # Data Visualization Best Practices
  # Case Study: California Health Information Survey

# Statistics Layer
  # Two categories of functions
    # Called from within a geom
    # Called independently
  # stat_

# geom_ <-> stat_
p <- ggplot(iris, aes(x = Sepal.Width))
p + geom_histogram()
p + geom_bar()
p + stat_bin()

# grouping by fill
ggplot(mtcars, aes(x = factor(cyl), fill = factor(am)))+
  geom_bar()
ggplot(mtcars, aes(x = factor(cyl), fill = factor(am)))+
  stat_bin() # doesn't work lol
  # stat_      | geom _
  # stat_bin() | geom_histogram
  # stat_bin() | geom_bar()
  # stat_bin() | geom_freqpoly()

# geom_ <-> stat_
ggplot(mtcars, aes(x =mpg))+
  geom_histogram(fill = "skyblue")+
  geom_freqpoly(col = "red")
  # appreciate the error message now 

  # stat_         | geom _
  # stat_smooth() | geom_smooth

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species))+
  geom_point()+
  geom_smooth(se = FALSE, span = 04) # span for loess window 

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species))+
  geom_point()+
  geom_smooth(method = "lm", se = FALSE)

#================================================================================
# Smoothing
#================================================================================
# Explore the mtcars data frame with str()
str(mtcars)

# A scatter plot with LOESS smooth:
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point()+ 
  geom_smooth()

# A scatter plot with an ordinary Least Squares linear model:
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point()+ 
  geom_smooth(method = "lm")

# The previous plot, without CI ribbon:
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point()+
  geom_smooth(method = "lm", se = FALSE)

# The previous plot, without points:
ggplot(mtcars, aes(x = wt, y = mpg))+
  geom_smooth(method = "lm", se = FALSE)

#================================================================================
# Grouping variables
#================================================================================
# Define cyl as a factor variable
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F)

# Complete the following ggplot command as instructed
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F)+
  stat_smooth(method = "lm", se = F, aes(group = 1))

#================================================================================
# Modifying stat_smooth
#================================================================================
# Plot 1: change the LOESS span
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  # Add span below 
  geom_smooth(se = F, span = 0.7)

# Plot 2: Set the overall model to LOESS and use a span of 0.7
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F) +
  # Change method and add span below
  stat_smooth(method = "loess", span = 0.7, aes(group = 1), 
              se = F, col = "black")

# Plot 3: Set col to "All", inside the aes layer of stat_smooth()
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F) +
  stat_smooth(method = "loess",
              # Add col inside aes()
              aes(group = 1, col = "All"), 
              # Remove the col argument below
              se = F, span = 0.7)

# Plot 4: Add scale_color_manual to change the colors
myColors <- c(brewer.pal(3, "Dark2"), "black")
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F, span = 0.75) +
  stat_smooth(method = "loess", 
              aes(group = 1, col="All"), 
              se = F, span = 0.7) +
  # Add correct arguments to scale_color_manual
  scale_color_manual("Cylinders", values = myColors)

#================================================================================
# Modifying stat_smooth(2)
#================================================================================
# Plot 1: Jittered scatter plot, add a linear model (lm) smooth:
ggplot(Vocab, aes(x = education, y = vocabulary)) +
  geom_jitter(alpha = 0.2)+
  stat_smooth(method = "lm", se = F)

# Plot 2: Only lm, colored by year
ggplot(Vocab, aes(x = education, y = vocabulary,
                  col = factor(year))) +
  stat_smooth(method = "lm", se = F)

# Plot 3: Set a color brewer palette
ggplot(Vocab, aes(x = education, y = vocabulary,
                  col = factor(year))) +
  stat_smooth(method = "lm", se = F)+
  scale_color_brewer()

# Plot 4: Add the group, specify alpha and size
ggplot(Vocab, aes(x = education, y = vocabulary, col = year, group = factor(year))) +
  stat_smooth(method = "lm", se = F, 
              alpha = 0.6, size = 2) +
  scale_color_gradientn(colors = brewer.pal(9,"YlOrRd"))

#================================================================================
# Quantiles
#================================================================================
# Use stat_quantile instead of stat_smooth:
ggplot(Vocab, aes(x = education, y = vocabulary, col = year, group = factor(year))) +
  stat_quantile(alpha = 0.6, size = 2) +
  scale_color_gradientn(colors = brewer.pal(9,"YlOrRd"))

# Set quantile to 0.5:
# Use stat_quantile instead of stat_smooth:
ggplot(Vocab, aes(x = education, y = vocabulary, col = year, group = factor(year))) +
  stat_quantile(alpha = 0.6, size = 2,
                quantiles = 0.5) +
  scale_color_gradientn(colors = brewer.pal(9,"YlOrRd"))

#================================================================================
# Sum
#================================================================================
# Plot with linear and loess model
p <- ggplot(Vocab, aes(x = education, y = vocabulary)) +
  stat_smooth(method = "loess", aes(col = "red"), se = F) +
  stat_smooth(method = "lm", aes(col = "blue"), se = F) +
  scale_color_discrete("Model", labels = c("red" = "LOESS", "blue" = "lm"))

# Add stat_sum
p + stat_sum()

# Add stat_sum and set size range
p + stat_sum() + scale_size(range = c(1,10))
