#================================================================================
# ggplot 2 II: Chapter 2, Themes
#================================================================================
pacman::p_load(ggplot2, dplyr, tidyr, RColorBrewer)

#================================================================================
# Make iris.wide for video demonstration
# Add column with unique ids (don't need to change)
iris$Flower <- 1:nrow(iris)

iris.wide <- iris %>%
  gather(key, value, -Flower, -Species) %>%
  separate(key, c("Part", "Measure"), "\\.") %>%
  spread(Measure, value)

p <- ggplot(iris.wide, aes(Length, Width, col = Part)) +
  geom_point(position = position_jitter(), alpha = 0.7) +
  scale_color_brewer(palette = "Set1") 

p <- p + facet_grid(.~Species) # rows ~ columns 
p
#================================================================================
# Themes Layer
  # All the non-data ink
  # Visual elements not part of data
  # Three types
    # text        element_text()
    # line        element_line()
    # rectangle   element_rect()


# text

# theme( # text = element_text()
         # title =
         # plot.title =
         # legend.title =
         # axis.title = 
         # axis.title.x =
         # axis.title.y =
         # axis.text =
         # axis.text.x =
         # axis.text.y =
         # strip.text =
         # strip.text.x =
         # strip.text.y =
         # )
p + theme(text = element_blank())

# line

# theme( # line = element_line()
         # axis.ticks
         # axis.ticks.x
         # axis.ticks.y
         # axis.line
         # axis.line.x
         # axis.line.y
         # panel.grid
         # panel.grid.major
         # panel.grid.minor
         # panel.grid.major.x
         # panel.grid.major.y
         # panel.grid.minor.x
         # panel.grid.minor.y
         # )

p + theme(line = element_line())

# rect

# theme( # rect = element_rect()
         # legend.background
         # legend.key
         # panel.background
         # plot.background
         # strip.background
         # )
p + theme(rect = element_blank())

# We don't need to modify each one individually
  # They INHERIT from each other
  # text to the rest
  # line to the rest
  # rect to the rest

p + theme()

#================================================================================
# Rectangles
#================================================================================
library(gridExtra)
# infer z
z <- ggplot(mtcars, aes(wt, mpg, col = factor(cyl)))+
        geom_point(size = 3, alpha = 1)+
        geom_smooth(method = 'lm', se = F)+
        scale_color_brewer(palette = "Set1")+
        facet_grid(.~cyl)
z

# Plot 1: change the plot background color to myPink:
myPink = "#FEE0D2"
z + theme(plot.background = element_rect(fill = myPink))

# Plot 2: adjust the border to be a black line of size 3
z + theme(plot.background = element_rect(fill = myPink, color = 'black', size = 3))

# Plot 3: set panel.background, legend.key, legend.background 
# and strip.background to element_blank()
uniform_panels <- theme(panel.background = element_blank(), 
                        legend.key = element_blank(), 
                        legend.background=element_blank(), 
                        strip.background = element_blank())

z2 <- z + theme(plot.background = element_rect(fill = myPink, color = 'black', size = 3)) +
         uniform_panels


# Extend z with theme() function and three arguments
z3 <- z2 + theme(panel.grid = element_blank(), 
          axis.line = element_line(color = 'black'),
          axis.ticks = element_line(color = 'black'))
z3
#================================================================================
# Rectangles
#================================================================================
myRed = "#99000D"
# Extend z with theme() function and four arguments
z4 <- z3 + theme(
        
        strip.text = element_text(size = 16, color = myRed), 
        
        axis.title.x = element_text(color = myRed, hjust = 0, face = "italic"), 
        
        axis.title.y = element_text(color = myRed, hjust = 0, face = "italic"), 
        
        axis.text = element_text(size = 16, color = 'black'))

z4
#================================================================================
# Legends
#================================================================================
# Move legend by position
z4 + theme(legend.position = c(0.85,0.85))

# Change direction
z4 + theme(legend.direction = "horizontal")

# Change location by name
z4 + theme(legend.position = "bottom")

# Remove legend entirely
z4 + theme(legend.position = "none")

#================================================================================
# Positions
#================================================================================

# Increase spacing between facets
library(grid)
z4 + theme(panel.margin.x = unit(2,"cm"))


# Add code to remove any excess plot margin space
z + theme(panel.margin.x = unit(2,"cm"),
          plot.margin = unit(c(0,0,0,0), "cm"))
