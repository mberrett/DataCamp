#================================================================================
# ggplot 2 II: Chapter 2, Themes
#================================================================================
pacman::p_load(ggplot2, dplyr, tidyr, RColorBrewer)
#================================================================================
# Recycling Themes
#================================================================================
# Recycling Themes
  # Many plots
  # Consistency in style
  # Apply specific theme everywhere 

#================================================================================
# z
z <- ggplot(iris, aes(Sepal.Length, Sepal.Width, col = Species)) +
     geom_jitter(alpha = 0.7) +
     scale_color_brewer("Species",
                        palette = "Dark2",
                        labels = c("Setosa",
                                   "Versicolor",
                                   "Virginica")) +
     scale_y_continuous("Width (cm)", limits = c(2,4.5), expand = c(0,0))+
     scale_x_continuous("Length (cm)", limits = c(4,8), expand = c(0,0))+
     ggtitle("Sepals")+
     coord_fixed(1)

z
z + theme(panel.background = element_blank(),
          legend.background = element_blank(),
          legend.key = element_blank(),
          panel.grid = element_blank(),
          axis.text = element_text(color = "black"),
          axis.line = element_line(color = "black"))

# Save theme 
theme_iris <- theme(panel.background = element_blank(),
                    legend.background = element_blank(),
                    legend.key = element_blank(),
                    panel.grid = element_blank(),
                    axis.text = element_text(color = "black"),
                    axis.line = element_line(color = "black"))

z + theme_iris
#================================================================================
# Apply it to a new plot 
iris$Flower <- 1:nrow(iris)

iris.wide <- iris %>%
  gather(key, value, -Flower, -Species) %>%
  separate(key, c("Part", "Measure"), "\\.") %>%
  spread(Measure, value)

m <- ggplot(iris.wide, aes(Length, Width, col = Part)) +
  geom_point(position = position_jitter(), alpha = 0.7) +
  scale_color_brewer(palette = "Set1") +
  facet_grid(.~Species)

m + theme_iris # because we didnt account for strip.background of facet
               # grey still appears
#================================================================================
# Extended Theme
m + theme_iris + # no need to remake theme_iris
      theme(strip.background = element_blank()) # we can just add what's lacking

theme_iris <- theme_iris + theme(strip.background = element_blank())

#================================================================================
# Discrete x-axis
iris$Flower <- NULL #in case Flower is part of the data set 

iris.tidy <- iris %>%
  gather(key, Value, -Species) %>%
  separate(key, c("Part", "Measure"), "\\.")

p <- ggplot(iris.tidy, aes(x = Measure, y = Value, col = Part)) +
            geom_jitter() + #jitter moves it around so you can see the points
            facet_grid(.~Species) # split across columns 
p + theme_iris


# to remove x axis black line
theme_iris_disX <- theme_iris +
                   theme(axis.line.x = element_blank(),
                         axis.ticks.x = element_blank(),
                         axis.text.x = element_text(angle = 45,
                                                    hjust = 1))
# Derivative Theme
p + theme_iris_disX

#================================================================================
# Built-in theme templates

# Theme classic, same as our theme_iris
z + theme_classic()
z + theme_iris

# just like before we can edit it
m + theme_classic() +
  theme(strip.background = element_blank())

# install.packages('ggthemes')
library(ggthemes)

# most popular : tufte, removes all data ink and sets font to a serif typeface
z + theme_tufte()

# Theme update
  # similar to par() function for utils plots
original <- theme_update(...)
# sets themes (globally) for all ggplots without having to specify them!

# Theme set
  # same as theme_update for built-in templates
theme_set(theme_classic())
z
theme_set(theme_gray()) # DEFAULT
z

#================================================================================
# Update Themestheme update
#================================================================================

#================================================================================
# Exploring ggthemes
#================================================================================
z2 <- ggplot(mtcars, aes(wt, mpg, col = factor(cyl))) +
            geom_point() +
            geom_smooth(method = "lm", se = F) +
            scale_fill_gradientn(colors = myBlues)
z2

# Load ggthemes package
library(ggthemes)

# Apply theme_tufte
z2 + theme_tufte()
z2

# Apply theme_tufte, modified:
z2 + theme_tufte() +
  theme(legend.position = c(0.9, 0.9), 
        legend.title = element_text(face = "italic", size = 12), 
        axis.title = element_text(face = "bold", size = 14))

