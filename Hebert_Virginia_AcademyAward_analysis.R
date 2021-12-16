################################################################################

# Title:  Oscar Metrics
# Purpose:  Final Project
# Author: Virginia Hebert
# Date: Nov 18, 2021
# Contact Info: vaelswick@yahoo.com
# Notes: some parsing and analysis of Oscar winners over the years

################################################################################

# run at the beginning of every instance
library(tidyverse)
library(ggplot2)
library(ggpubr)

############################# IMPORT & TIDY ####################################

# read in csv file with data that I created in Excel and saved as a csv
# for use in this project
oscar = read_csv(
  "C:/Users/Virginia.Hebert/OneDrive - Centrica/Desktop/R Studio/AcademyAward_winners.csv",
  col_types = cols(
    Born = col_double()))

# view the table
oscar

# check for issues
problems(oscar)

# expand number of rows viewable to 40
oscar %>% tibble::as_tibble() %>% print(n=40)

# because I created the file in Excel, I did all the cleanup beforehand, so 
# there is no tidying that needs to be done


################## TRANSFORM, PROGRAM, MODEL & VISUALIZE #######################

# my goal is to visualize the differences in age of Oscar winners between males
# and females and attempt to see if there has been a change over time due to 
# higher acceptance of aging actors


# calculate the age of the winner at the time they won most recent award
oscar2 = mutate(oscar, win_age = Most_recent_win - Born)

# histogram of total number wins at each age, regardless of sex
oscar2 %>%
  ggplot() + geom_histogram(mapping = aes(x = win_age), binwidth = 1) +
  ggtitle("Count of Wins per Age") + labs(x = "Age", y = "Wins") + 
  scale_x_continuous(breaks=seq(0,90,10))

# histogram of total number of wins for females
# note that highest number of wins is around 30 years old
oscar2 %>% filter(Sex == "F") %>%
  ggplot() + geom_histogram(mapping = aes(x = win_age), binwidth = 1) +
  ggtitle("Count of Wins per Age, Female") + labs(x = "Age", y = "Wins") + 
  scale_x_continuous(breaks=seq(0,90,10))

# histogram of total number of wins for males
# note that highest number of wins is 40+ years old
oscar2 %>% filter(Sex == "M") %>%
  ggplot() + geom_histogram(mapping = aes(x = win_age), binwidth = 1) +
  ggtitle("Count of Wins per Age, Male") + labs(x = "Age", y = "Wins") + 
  scale_x_continuous(breaks=seq(0,90,10))

# a boxplot allows you to compare the spread and average of male versus female
# in a single plot; appears to be around a ten year difference between the 
# median ages of male and female winners
oscar2 %>% 
  ggplot(mapping = aes(x = Sex, y = win_age)) + 
  geom_boxplot() +
  ggtitle("Spread of Wins per Age") + labs(x = "Sex", y = "Wins")

# attempting to see if the age of winners has increased with time, indicating
# more acceptance of older actors

# point plot of  age of winners over time, regardless of sex
# regression line fitted using the lm() method
oscar2 %>% 
  ggplot(aes(x = Most_recent_win, y = win_age)) + 
  geom_point() + geom_smooth(method="lm") +
  stat_regline_equation(label.x=1940, label.y=80) +
  stat_cor(aes(label=..rr.label..), label.x=1940, label.y=77) +
  ggtitle("Wins over Time") + labs(x = "Years", y = "Wins") 

# point plot of age of winners over time for females with trend line and R2
# while it does appear age of winners has increased over time, the R2 shows 
# that it's not statistically significant
oscar2 %>% filter(Sex == "F") %>%
  ggplot(aes(x = Most_recent_win, y = win_age)) + 
  geom_point() + geom_smooth(method="lm") +
  stat_regline_equation(label.x=1940, label.y=80) +
  stat_cor(aes(label=..rr.label..), label.x=1940, label.y=77) +
  ggtitle("Wins over Time, Female") + labs(x = "Years", y = "Wins") 

# point plot of age of winners over time for males with trend line and R2
# same for the males - an increase over time, but not significant
oscar2 %>% filter(Sex == "M") %>%
  ggplot(aes(x = Most_recent_win, y = win_age)) + 
  geom_point() + geom_smooth(method="lm") +
  stat_regline_equation(label.x=1940, label.y=80) +
  stat_cor(aes(label=..rr.label..), label.x=1940, label.y=77) +
  ggtitle("Wins over Time, Male") + labs(x = "Years", y = "Wins")

# calculate age at first nomination
oscar3 = mutate(oscar2, nom_age = First_nom - Born)
  
# view table 
# sorted by ascending age
oscar3 %>% 
  arrange(nom_age) %>% 
  tibble::as_tibble() %>% print(n=30)

# and descending
oscar3 %>% 
  arrange(desc(nom_age)) %>% 
  tibble::as_tibble() %>% print(n=30)

# boxplot comparing age of first nomination to sex
# spread of the means doesn't appear to be quite as wide as wins
oscar3 %>% 
  ggplot(mapping = aes(x = Sex, y = nom_age)) + 
  geom_boxplot()  +
  labs(x = "Sex", y = "Nomination Age") + 
  scale_y_continuous(breaks=seq(0,90,10))

# determine the number of posthumous nominations and wins
oscar4 = mutate(oscar3, nom_age_from_death = Died - First_nom, 
                win_age_from_death = Died - Most_recent_win)

# view table sorted by win_age_from_death
# it appears that Heath Ledge is the only winner post-humously
oscar4 %>% 
  arrange(win_age_from_death) %>% 
  select(-First_film) %>%
  tibble::as_tibble() %>% print(n=30)

# view table sorted by nom_age_from_death
# there are a handful of actors nominated either after or in the year of their 
# death
oscar4 %>% 
  arrange(nom_age_from_death) %>% 
  select(-First_film) %>%
  tibble::as_tibble() %>% print(n=30)

  
# a rather superfluous analysis of Oscar nominations and winners, but a good
# dataset for using some basic R analysis and methods to manipulate and view
# the data

#################################### EOF #######################################
 
