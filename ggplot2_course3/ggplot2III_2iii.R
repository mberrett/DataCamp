#===========================================================================================
# ggplot2 III: Chapter 3: Specialized Plots
#===========================================================================================
# VIDEO: Diagnostic Plots
#===========================================================================================
# Diagnostic Plots
# o Quantitative data
# o Ordinary least squares model
# o Assess how the model fits the data

# trees
dim(trees)
head(trees)

# Linear model
res <- lm(Volume ~ Girth, data = trees)
plot(Volume ~ Girth, data = trees)
abline(res, col = "red")

ggplot(trees, aes(Girth, Volume))+
  geom_point(shape = 16, alpha = 0.7)+
  stat_smooth(method = "lm", se = F, col = "red")

# four diagnostic plots

# plot model (1) 
plot(res) # ideally no relationship

# plot model (2) - normally distributed or skewed 
plot(res) # Are residuals normally distributed?

# plot model (3) - homeoscedasticity
plot(res) # there should be no clear patterns

# plot model (4) - leverage
plot(res) 

# car package
library(car)
qqPlot(res, id.method = "identify",
       simulate = TRUE, main = "Q-Q Plot")


influencePlot(res, id.method = "identify",
       simulate = TRUE, main = "Influence Plot")

# Recent development
# o John Fox
# o Michael Friendly
# o matlib 


#===========================================================================================
# Autoplot on linear models
#===========================================================================================
# Create linear model: res
res <- lm(Volume ~ Girth, data = trees)

# Plot res
plot(res)

# Import ggfortify and use autoplot()
library(ggfortify)
autoplot(res, ncol = 2)


#===========================================================================================
# Plotting K-means clustering
#===========================================================================================
pacman::p_load(ggfortify)

# Perform clustering
iris_k <- kmeans(iris[-5], centers = 3)

# Autoplot: color according to cluster
autoplot(iris_k, data = iris, frame = TRUE)

# Autoplot: color according to species
autoplot(iris_k, data = iris, frame = TRUE, col = 'Species')
