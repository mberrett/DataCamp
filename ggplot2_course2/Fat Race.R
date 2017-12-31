# What race is the fatest?

# Download and set up the data
ADULT <- read_csv('adult_clean.csv')

dim(ADULT)
summary(ADULT)

ADULT$rbmi<- factor(ADULT$rbmi)
ADULT$rbmi <- ordered(ADULT$rbmi, 
                      levels = c("Under-weight", "Normal-weight", "Over-weight", "Obese"))

ADULT$racehpr2 <- factor(ADULT$racehpr2)

dim(ADULT)
summary(ADULT)


# Let's get to plotting
ggplot(ADULT, aes(x = bmi_p, fill = factor(racehpr2)))+
  geom_histogram(binwidth = 1)

ggplot(ADULT, aes(x = racehpr2, fill = factor(rbmi)))+
  geom_histogram(binwidth = 1, stat = "count", position = "fill")

ggplot(ADULT, aes(x = racehpr2, fill= rbmi)) + 
  geom_histogram(binwidth = 1, stat = "count", position = "fill") +
  BMI_fill
