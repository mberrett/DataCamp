#================================================================================
# ggplot: Chapter 5 : Qplot
#================================================================================
# VIDEO 1: QPLOT is the quick and dirty GGPLOT2
library(ggplot2)
qplot(Sepal.Length, Sepal.Width, data = iris)
  #no need to specify geom

#================================================================================
# 1) Using qqplot 
# The old way (shown)
plot(mpg ~ wt, data = mtcars)

# Using ggplot:
ggplot(mtcars, aes(wt, mpg))+
  geom_point()

# Using qplot:
qplot(wt, mpg, data = mtcars)

#================================================================================
# 2) Using aesthetics
# basic scatter plot:
qplot(wt, mpg, data = mtcars)

# Categorical:
# cyl
qplot(wt, mpg, data = mtcars, size = cyl)

# gear
qplot(wt, mpg, data = mtcars, size = gear)

# Continuous
# hp
qplot(wt, mpg, data = mtcars, col = factor(hp))

# qsec
qplot(wt, mpg, data = mtcars, col = factor(qsec))

#================================================================================
# 3) Choosing geoms, part 1

# qplot() with x only
qplot(factor(cyl), data = mtcars )

# qplot() with x and y
qplot(factor(cyl), factor(vs), data = mtcars )

# qplot() with geom set to jitter manually
qplot(factor(cyl), factor(vs), geom = "jitter", data = mtcars )

#================================================================================
# 4) Choosing geoms, part 2 - dotplot

# Make a dot plot with ggplot
ggplot(mtcars, aes(cyl, wt, fill = factor(am)))+
  geom_dotplot(stackdir = "center",
               binaxis = "y")


# qplot with geom "dotplot", binaxis = "y" and stackdir = "center"
qplot(cyl, wt, fill = factor(am),geom = "dotplot",
      stackdir = "center", binaxis = "y",
      data = mtcars)

#================================================================================
# VIDEO 2: Wrap-up 

# 1) Who's the audience? (Statistics and Design)
# 2) Grammar of graphics (Grammatical Elements and Aesthetic Mapping)

#================================================================================
# 5) ChickWeight

# Check out the head of ChickWeight
head(ChickWeight)

# Use ggplot() for the second instruction
ggplot(ChickWeight, aes(Time, weight))+
  geom_line(aes(group = Chick))

# Use ggplot() for the third instruction
ggplot(ChickWeight, aes(Time, weight, col = Diet))+
  geom_line(aes(group = Chick))

# Use ggplot() for the last instruction
ggplot(ChickWeight, aes(Time, weight, col = Diet))+
  geom_line(aes(group = Chick),alpha = 0.3)+
  geom_smooth(lwd = 2, se = F)

#================================================================================
# 6) Titanic 
# Check out the structure of titanic
tfile <- ("Data/R_Data/Data Camp/ggplot2/train.csv")
titanic <- read.csv(tfile)
str(titanic)

# Use ggplot() for the first instruction
ggplot(titanic, aes(factor(Pclass), fill = factor(Sex)))+
  geom_bar(position = "dodge")

# Use ggplot() for the second instruction
ggplot(titanic, aes(factor(Pclass), fill = factor(Sex)))+
  geom_bar(position = "dodge")+
  facet_grid(".~Survived")

# Position jitter (use below)
posn.j <- position_jitter(0.5, 0)

# Use ggplot() for the last instruction
ggplot(titanic, aes(factor(Pclass),Age, col = factor(Sex)))+
  geom_jitter(size = 3, alpha = 0.5,
              position = posn.j)+
  facet_grid(".~Survived")

