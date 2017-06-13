#================================================================================
# ggplot: Chapter 4 : Geometries: Line Plots
#================================================================================
# VIDEO 1: Bar Plots
library(ggplot2)
library(datasets)
# vcdExtra::datasets("datasets") to see data in package
#===================
# 
ggplot(beaver2, aes(x = time, y = temp))+
  geom_line()
# [UNDER CONSTRUCTION] VIDEO 1: Line Plots - Time Series [DOESN'T WORK YET]
ggplot(beaver2, aes(x = time, y = temp, col = as.factor(activ)))+
  geom_line() # line will be severed if not in Date or POSIXct format 
#===============================================================================
fishpath <- ("Data/R_Data/Data Camp/ggplot2/43fish.txt")
f <- read.delim(fishpath, sep = "")
f$No <- NULL


#================================================================================
# 1) 
# Print out head of economics
head(economics)

# Plot unemploy as a function of date using a line plot
ggplot(economics, aes(x = date, y = unemploy)) +
  geom_line()

# Adjust plot to represent the fraction of total population that is unemployed
ggplot(economics, aes(x = date, y = unemploy/pop)) +
  geom_line()

# couldn't find recess data frame so I'll make it myself 

begin1 <- list("1969-12-01", "1973-11-01", "1980-01-01", 
               "1981-07-01", "1990-07-01"," 2001-03-01") 

begin <- as.Date(unlist(begin1)) # unlist list to turn elements into Dates

end1 <- list("1970-11-01","1975-03-01","1980-07-01",
             "1982-11-01","1991-03-01","2001-11-01")

end <- as.Date(unlist(end1)) # unlist list to turn elements into Dates

str(begin) #check both to make sure they're Date[1:6]
str(end)

recess <- data.frame(begin, end) # put them together in a data frame 
str(recess)

# Expand the following command with geom_rect() to draw the recess periods
ggplot(economics, aes(x = date, 
                      y = unemploy/pop)) +
  geom_line()+
  geom_rect(data = recess, 
            inherit.aes = FALSE,
            aes(xmin = begin, xmax = end,
                ymin = -Inf, ymax = +Inf),
            fill = "red", alpha = 0.2)



#================================================================================
# Multiple time series, part 2

# Recreate the plot shown on the right
ggplot(f, aes(x = Year, y = Capture,
                      col= Species)) +
  geom_line()



