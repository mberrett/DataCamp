#=============================================================
# ggplot2 II, Chapter 5: CHIS - Descriptive Statistics
#=============================================================
ADULT <- read_csv('adult_clean.csv')
dim(ADULT)
summary(ADULT)

# ADULT$racehpr2 <- factor(ADULT$racehpr2)
# ADULT$rbmi<- factor(ADULT$rbmi)

#=============================================================
# VIDEO: CHIS - Mosaic Plots
#=============================================================
# California Health Information Survey Mosaic Plots

# Mosaic Plot
  # 268 rectangles, their width varies across x (total number of individuals)
  # Each bar is representative of its proportion in the whole data set
  # A large area that equals one

# Giant contingency table
  # bmi category
  # and age (treat it as ordinal)
    # we want to know if prop of one varible (bmi) 
    # within groups of another variable (age)
    # stray from the null model of equal proportions

# Chi-Squared Test
  # Mosaic Plots help understand this
  # Residuals: tell us something about the observed data and expected values
  # under the null hypotheis of equal proportions

  # the higher the residual the more over-represented a segment is 
    # Mosaic plot helps report statistics
    # statistics + design = meaningful figures 

# We're gonna color each 268 rectangles according to their residuals
  #  o Underweight and healthy weight individuals are over-represented 
  #    at low and high end of spectrum
  # o  Drop off of obesity at high end of spectrum 

# Closing Notes
  # Concepts and Practice
  # Essential skill
  # Consider purpose & audience
  # Course 3:
    # Advanced statistical plots
    # ggplot2 internals
    # accessory packages

#=============================================================
# 
#=============================================================
# Reorder levels in rbmi

ADULT$rbmi<- factor(ADULT$rbmi)
ADULT$rbmi <- ordered(ADULT$rbmi, 
                      levels = c("Under-weight", "Normal-weight", "Over-weight", "Obese"))

# The initial contingency table
DF <- as.data.frame.matrix(table(ADULT$srage_p, ADULT$rbmi))
str(DF)

# Add the columns groupsSum, xmax and xmin. Remove groupSum again.
DF$groupSum <- rowSums(DF)
DF$xmax <- cumsum(DF$groupSum)
DF$xmin <- (DF$xmax - DF$groupSum)
# The groupSum column needs to be removed, don't remove this line
DF$groupSum <- NULL

# Copy row names to variable X
DF$X <- row.names(DF)

# Melt the dataset
library(reshape2)
DF_melted <- melt(DF, id.vars = c("X","xmin","xmax"),
                  variable.name = "FILL")

# dplyr call to calculate ymin and ymax - don't change
library(dplyr)
DF_melted <- DF_melted %>% 
  group_by(X) %>% 
  mutate(ymax = cumsum(value/sum(value)),
         ymin = ymax - value/sum(value))

# Plot rectangles - don't change.
library(ggthemes)
ggplot(DF_melted, aes(ymin = ymin, 
                      ymax = ymax,
                      xmin = xmin, 
                      xmax = xmax, 
                      fill = FILL)) + 
  geom_rect(colour = "white") +
  scale_x_continuous(expand = c(0,0)) +
  scale_y_continuous(expand = c(0,0)) +
  BMI_fill +
  theme_tufte()




# Perform chi.sq test (RBMI and SRAGE_P)
results <- chisq.test(table(ADULT$rbmi, ADULT$srage_p))

# Melt results$residuals and store as resid
resid <- melt(results$residuals)

# Change names of resid
names(resid) <- c("FILL","X","residual")

# merge the two datasets:
DF_all <- merge(DF_melted, resid)

# Update plot command
library(ggthemes)
ggplot(DF_all, aes(ymin = ymin, 
                   ymax = ymax,
                   xmin = xmin, 
                   xmax = xmax, 
                   fill = residual)) + 
  geom_rect() +
  scale_fill_gradient2() +
  scale_x_continuous(expand = c(0,0)) +
  scale_y_continuous(expand = c(0,0)) +
  theme_tufte()

#=============================================================
# Adding text
#=============================================================

# Position for labels on x axis
DF_all$xtext <- DF_all$xmin + (DF_all$xmax - DF_all$xmin)/2

# Position for labels on y axis (don't change)
index <- DF_all$xmax == max(DF_all$xmax)
DF_all$ytext <- DF_all$ymin[index] + (DF_all$ymax[index] - DF_all$ymin[index])/2

# Plot
ggplot(DF_all, aes(ymin = ymin, ymax = ymax, xmin = xmin, 
                   xmax = xmax, fill = residual)) + 
  geom_rect(col = "white") +
  # geom_text for ages (i.e. the x axis)
  geom_text(aes(x = xtext, 
                label = X),
            y = 1,
            size = 3,
            angle = 90,
            hjust = 1,
            show.legend = FALSE) +
  # geom_text for BMI (i.e. the fill axis)
  geom_text(aes(x = max(xmax), 
                y = ytext,
                label = FILL),
            size = 3,
            hjust = 1,
            show.legend  = FALSE) +
  scale_fill_gradient2() +
  theme_tufte() +
  theme(legend.position = "bottom")


#=============================================================
# Adding text
#=============================================================
# Load all packages
library(ggplot2)
library(reshape2)
library(dplyr)
library(ggthemes)

# Script generalized into a function
mosaicGG <- function(data, X, FILL) {
  
  # Proportions in raw data
  DF <- as.data.frame.matrix(table(data[[X]], data[[FILL]]))
  DF$groupSum <- rowSums(DF)
  DF$xmax <- cumsum(DF$groupSum)
  DF$xmin <- DF$xmax - DF$groupSum
  DF$X <- row.names(DF)
  DF$groupSum <- NULL
  DF_melted <- melt(DF, id = c("X", "xmin", "xmax"), variable.name = "FILL")
  library(dplyr)
  DF_melted <- DF_melted %>% 
    group_by(X) %>% 
    mutate(ymax = cumsum(value/sum(value)),
           ymin = ymax - value/sum(value))
  
  # Chi-sq test
  results <- chisq.test(table(data[[FILL]], data[[X]])) # fill and then x
  resid <- melt(results$residuals)
  names(resid) <- c("FILL", "X", "residual")
  
  # Merge data
  DF_all <- merge(DF_melted, resid)
  
  # Positions for labels
  DF_all$xtext <- DF_all$xmin + (DF_all$xmax - DF_all$xmin)/2
  index <- DF_all$xmax == max(DF_all$xmax)
  DF_all$ytext <- DF_all$ymin[index] + (DF_all$ymax[index] - DF_all$ymin[index])/2
  
  # plot:
  g <- ggplot(DF_all, aes(ymin = ymin,  ymax = ymax, xmin = xmin, 
                          xmax = xmax, fill = residual)) + 
    geom_rect(col = "white") +
    geom_text(aes(x = xtext, label = X),
              y = 1, size = 3, angle = 90, hjust = 1, show.legend = FALSE) +
    geom_text(aes(x = max(xmax),  y = ytext, label = FILL),
              size = 3, hjust = 1, show.legend = FALSE) +
    scale_fill_gradient2("Residuals") +
    scale_x_continuous("Individuals", expand = c(0,0)) +
    scale_y_continuous("Proportion", expand = c(0,0)) +
    theme_tufte() +
    theme(legend.position = "bottom")
  print(g)
}

# BMI described by age
mosaicGG(ADULT, "srage_p","rbmi")

# Poverty described by age
mosaicGG(ADULT, "srage_p","povll")

# mtcars: am described by cyl
mosaicGG(mtcars, "cyl", "am")

# Vocab: vocabulary described by education
library(car)
mosaicGG(Vocab, "education","vocabulary")
