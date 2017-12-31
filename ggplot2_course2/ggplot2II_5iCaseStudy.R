#=============================================================
# ggplot2 II, Chapter 5: CHIS - Descriptive Statistics
#=============================================================

# Data
  # Largest state health survey in US
  # Wide variety of variety of variables
  # Personal health and economic measurements
  # Original dataset
    # dim(adult) = 47614 536
  # Reduced dataset
    # dim(adult) = 47614 10

  # Variables
  # RBMI           BMI Category Description
  # BMI_P          BMI Value
  # RACEHPR2       Race
  # SRSEX          Sex
  # SRAGE          Age
  # MARIT2         Marital Status
  # AB1            General Health Condition
  # ASTCUR         Current Asthma Status
  # AB51           Type I or Type II Diabetes
  # POVLL          Poverty level

# BMI is ordinal

# http://healthpolicy.ucla.edu/

# Range       Classification
# 0-18.49     Underweight
# 18.5-24.99  Healthy-weight
# 25.0-29.99  Over-weight
# 30.0+       Obese
pacman::p_load(dplyr, tidyr, ggplot2, readr, RColorBrewer)
#=============================================================
# Retrieved data as sas dta file from the following link: 
# http://healthpolicy.ucla.edu/chis/data/Pages/GetCHISData.aspx
# adult <- read_dta("ADULT.dta")
# View(adult)
# names(adult)
# adult_check <- select(adult, rbmi, bmi_p, racehpr2, srsex, srage_p, 
#                      marit2, ab1, astcur, ab51, povll)
# head(adult_check)
# write.csv(adult_check, "adult.csv")
#=============================================================
adult <- read_csv('adult.csv')
adult$X1 <- NULL
dim(adult)
head(adult)

# Age
ggplot(adult, aes(x = srage_p))+
  geom_histogram()
# peaks or issue with vis system
diff(range(adult$srage_p)) / 30
# bin of 2.23 not very useful
# we need to clean it up

# BMI
ggplot(adult, aes(x = bmi_p))+
  geom_histogram()
# unexpected pos skew
# we may remove extreme values
  # extreme weights may bring about spurious results

# BMI & AGE
ggplot(adult, aes(x = srage_p, y = bmi_p))+
  geom_point()

ggplot(adult, aes(x = srage_p, y = bmi_p, col = factor(rbmi)))+
  geom_point(alpha = 0.4, position = position_jitter(width = 0.5))
# difficult to know how many in each group

# Change labels for rbmi factor
adult$rbmi <- as.character(adult$rbmi)

# adult$rbmi[adult$rbmi == 1] <- "Under-Weight"
# adult$rbmi[adult$rbmi == 2] <- "Healthy-Weight"
# adult$rbmi[adult$rbmi == 3] <- "Over-Weight"
# adult$rbmi[adult$rbmi == 4] <- "Obese"

adult$rbmi <- factor(adult$rbmi, 
                     labels = c("Under-weight","Normal-weight","Over-weight","Obese"))

adult$rbmi <- factor(adult$rbmi)
head(adult$rbmi)

# histogram is the solution
ggplot(adult, aes(x = srage_p, fill = rbmi))+
  geom_histogram() 

# The color scale used in the plot
BMI_fill <- scale_fill_brewer("BMI Category", palette = "Reds")

# histogram
ggplot(adult, aes(x = srage_p, fill = rbmi))+
  geom_histogram(aes(y = ..count../sum(..count..)),
  binwidth = 1, position = "fill") +
  BMI_fill

#=============================================================
# Exploring Data
#=============================================================
# Explore the dataset with summary and str
summary(adult)
str(adult)

# Age histogram
ggplot(adult, aes(x = srage_p))+
  geom_histogram()


# BMI histogram
ggplot(adult, aes(x = bmi_p))+
  geom_histogram()

# Age colored by BMI, default binwidth
ggplot(adult, aes(x = srage_p, fill = factor(rbmi)))+
  geom_histogram(binwidth = 1)

#=============================================================
# Unusual Values
#=============================================================
# Q: What unusual phenomenon stood out?
# A: There is an unexpectedly large number of very old people.
# Yes, it looks like everyone 85 and above has been categorized as 85 years old.

#=============================================================
# Default binwidths
#=============================================================
# If you don't specify the binwidth argument inside geom_histogram() 
# you can tell from the message that 30 bins are used by default
# What is this binwidth for the age variable, SRAGE_P, of the adult dataset?

diff(range(adult$srage_p))/30
# Correct! This is a pretty inconvenient range for these values.

#=============================================================
# Default binwidths
#=============================================================
# Remove individual aboves 84
adult <- adult[adult$srage_p <= 84, ] 

# Remove individuals with a BMI below 16 and above or equal to 52
adult <- adult[adult$bmi_p >= 16 & adult$bmi_p < 52, ]

#=================================================================
# Hold on a minute: RACE # BE SURE TO RUN THE ABOVE BEFORE STARTING
summary(adult$racehpr2)

adult$RACEHPR2 <- factor(adult$racehpr2)
summary(adult$RACEHPR2)

# 1       LATINO
# 2       PACIFIC ISLANDER
# 3       AMERICAN INDIAN/ALASKAN NATIVE
# 4       ASIAN
# 5       AFRICAN AMERICAN
# 6       WHITE
# 7       OTHER SINGLE/MULTIPLE RACE

# My Race Variable
#    1     2     3     4     5     6     7 
# 5643    72   485  4750  1875 29899  2636 
mr <- 5643 + 72 + 485 + 4750+ 1875 + 29899 + 2636

# Data camp RACEHPR2
# Latino            Asian African American            White 
# 5643             4750             1875            29899

# DataCamp's Race
dcr <- 5643 + 4750 + 1875 + 29899

# difference between my race var and data camp's race var == difference in row dimension
mr - dcr == 45360 - 42167

# my dim - datacamp's dims
45360 - 42167 # 3193 = 72 + 485 + 2636

#       2     3     7   <- Ethnicities removed 
3193 - 72 - 485 - 2636 # 0 

adult[adult$RACEHPR2 == 2,] # Pacific Islander
adult[adult$RACEHPR2 == 3,] # American Indian
adult[adult$RACEHPR2 == 7,] # Other 

# Only keep Latino Asian African-American and White
pacman::p_load(dplyr, tidyr)

ADULT <- adult %>%
        filter(RACEHPR2 != 7 & RACEHPR2 != 3 & RACEHPR2 != 2)

sum(is.na(ADULT$RACEHPR2))
sum(is.na(ADULT))

summary(ADULT)

summary(ADULT$RACEHPR2)

dim(ADULT)[1] == 42167 # SUCCESS

# NOW DROP LEVELS
ADULT$RACEHPR2_2 <- as.integer(ADULT$RACEHPR2)
ADULT$RACEHPR2_2[ADULT$RACEHPR2_2 == 4] <- 2 # Asian to 2
ADULT$RACEHPR2_2[ADULT$RACEHPR2_2 == 5] <- 3 # African A to 3
ADULT$RACEHPR2_2[ADULT$RACEHPR2_2 == 6] <- 4 # White to 4

# Relabel the race variable:
ADULT$RACEHPR2_2 <- factor(ADULT$RACEHPR2_2,
                              labels = c("Latino","Asian","African American","White"))

summary(ADULT$RACEHPR2_2) # Success!


# DELETE RACEHPR2 racehpr and turn RACEHPR2_2 into the new racehpr 
ADULT$RACEHPR2 <- NULL
ADULT$racehpr2 <- NULL

ADULT$racehpr2 <- ADULT$RACEHPR2_2
ADULT$RACEHPR2_2 <- NULL

summary(ADULT$racehpr2) # Success!
#=========================================================================================
# Relabel the BMI categories variable: (NOW OPERATING FROM ADULT rather than adult)
ADULT$rbmi <- factor(ADULT$rbmi, 
                     labels = c("Under-weight","Normal-weight","Over-weight","Obese"))

summary(ADULT)
View(ADULT)
write_csv(ADULT, "adult_clean.csv")
#=============================================================
# Multiple Histograms
#=============================================================
# The dataset adult is available

# The color scale used in the plot
BMI_fill <- scale_fill_brewer("BMI Category", palette = "Reds")

# Theme to fix category display in faceted plot
fix_strips <- theme(strip.text.y = element_text(angle = 0, hjust = 0, vjust = 0.1, size = 14),
                    strip.background = element_blank(), 
                    legend.position = "none")

# Histogram, add BMI_fill and customizations
ggplot(ADULT, aes (x = srage_p, fill= factor(rbmi))) + 
  geom_histogram(binwidth = 1) +
  fix_strips + 
  BMI_fill +
  facet_grid(.~rbmi) +
  theme_classic()

#=============================================================
# Alternatives
#=============================================================

# Plot 1 - Count histogram
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) + 
  geom_histogram(binwidth = 1) +
  BMI_fill

# Plot 2 - Density histogram
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) + 
  geom_histogram(binwidth = 1, aes(y = ..density..)) +
  BMI_fill

# This plot looks really strange, 
# because we get the density within each BMI category, 
# not within each age group!

# Plot 3 - Faceted count histogram
ggplot(ADULT, aes (x = srage_p, fill= factor(rbmi))) + 
  geom_histogram(binwidth = 1) +
  BMI_fill +
  facet_grid(rbmi ~.)

# Plot 4 - Faceted density histogram
ggplot(ADULT, aes (x = srage_p, fill= factor(rbmi))) + 
  geom_histogram(binwidth = 1, aes(y = ..density..)) +
  BMI_fill +
  facet_grid(rbmi ~.)

#  Plots 3 and 4 can be useful if we are interested 
# in the frequency distribution within each BMI category.

# Plot 5 - Density histogram with position = "fill"
ggplot(ADULT, aes (x = srage_p, fill= factor(rbmi))) + 
  geom_histogram(binwidth = 1, aes(y = ..density..), position = "fill") +
  BMI_fill

#  This is not an accurate representation, 
# as density calculates the proportion across category, 
# and not across bin.

# Plot 6 - The accurate histogram
ggplot(ADULT, aes (x = srage_p, fill= factor(rbmi))) + 
  geom_histogram(binwidth = 1, aes(y = ..count../sum(..count..)), 
                 position = "fill") +
  BMI_fill

# To get an accurate visualization, change Plot 5, but this time, 
# instead of ..density.., set the y aesthetic to ..count../sum(..count..).

#=============================================================
# Do Things Manually
#=============================================================
# An attempt to facet the accurate frequency histogram from before (failed)
ggplot(adult, aes (x = srage_p, fill= factor(rbmi))) + 
  geom_histogram(aes(y = ..count../sum(..count..)), binwidth = 1, position = "fill") +
  BMI_fill +
  facet_grid(rbmi ~ .)

# Create DF with table()
DF <- table(adult$rbmi, adult$srage_p)

# Use apply on DF to get frequency of each group
DF_freq <- apply(DF, 2, function(x) x/sum(x))

# Load reshape2 and use melt on DF to create DF_melted
library(reshape2)
DF_melted <- melt(DF_freq)
# Change names of DF_melted
names(DF_melted) <- c("FILL","X","value")

# Add code to make this a faceted plot
ggplot(DF_melted, aes(x = X, y = value, fill = FILL)) +
  geom_bar(stat = "identity", position = "stack") +
  BMI_fill + 
  facet_grid(FILL ~ .) 


