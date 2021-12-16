# Title:  Assignment 6
# Purpose:  In book exercises
# Author: Virginia Hebert
# Date: Dec 13, 2021
# Contact Info: vaelswick@yahoo.com
# Notes: complete in-book exercises for Ch 19-21

############################# R for Data Science ###############################

# RUN FOR EVERY SCRIPT INSTANCE

install.packages("microbenchmark")
library(tidyverse)
library(magrittr)
library(stringr)
library(microbenchmark)


################################# 19.2.1 #######################################

# 3. 
x = c(1, 4, 78, 5.5, 784)

mean(is.na(x))
na_proportion = function(x) {mean(is.na(x))}
na_proportion(x)

x / sum(x, na.rm = TRUE)
sum_x = function(x) {x / sum(x, na.rm = TRUE)}
sum_x(x)
sum_x(1:7)

sd(x, na.rm = TRUE) / mean(x, na.rm = TRUE)
sd_mean = function(x) {sd(x, na.rm = TRUE) / mean(x, na.rm = TRUE)}
sd_mean(x)

# 4. 
variance = function(x, na.rm = TRUE) {
  n = length(x)
  mean = mean(x, na.rm = TRUE)
  sq = (x-mean)^2
  sum(sq)/(n-1)}
variance(1:10)

skew = function(x, na.rm = TRUE) {
  n = length(x)
  mean = mean(x, na.rm = TRUE)
  variance = var(x, na.rm = TRUE)
  (sum((x-mean)^3)/(n-2))/variance^(3/2)}
skew(x)

# 5. 
both_na = function(x, y) {sum(is.na(x) & is.na(y))}
x_na = c(NA, NA, 5, 7, NA, 82)
y_na = c(45, NA, 67, 8, NA, 44)
both_na(x_na, y_na)

# 6. is_directory checks if something is a directory
# is_readable checks if the pathway file is valid


################################# 19.3.1 #######################################

# 1. 
# f1 checks if the prefix is part of the string, prefix_check()
# f2 removes the last object of x and if there is only one, returns NULL, 
# remove_last()
# f3 repeats y for each index value of x, repeat_y()


################################# 19.4.4 #######################################

# 1. if is for one test, ifelse is for multiple tests

# 2. 
greeting = function(time = lubridate::now()) {
  hour = lubridate::hour(time)
  if (hour < 5) {print("go to bed!")}
  else if (hour < 12) {print("good morning")}
  else if (hour < 17) {print("good afternoon")}
  else {print("good evening")}
}
greeting()

# 3. 
fizzbuzz = function(x) {
  if ((x %% 3==0) && (x %% 5)==0) {print("fizzbuzz")}
  else if (x%%3==0) {print("fizz")}
  else if (x%%5==0) {print("buzz")}
  else {as.character(x)}
}
fizzbuzz(5)


################################# 20.4.6 #######################################

# 1. mean(is.na(x)) gives the proportion of values that are NA; 
# sum(!is.finite(x)) sums up the number of bits that are NA/infinite

# 2. is.vector determines if vector has no attributes other than names; 
# is.atomic checks if the object is an atomic type
?is.vector
?is.atomic

# 4. 
last_value = function(x) {
  if (length(x)) {x[[length(x)]]}
  else {x}
}
even_index = function(x) {
  if (length(x)) {x[seq_along(x) %% 2 == 0]}
  else {x}
}
not_last = function(x) {
  n = length(x) 
  if (n) {x[-n]}
  else {x}
}
even_nos = function(x) {
  x[x %% 2 == 0]
}


################################# 20.7.4 #######################################

# 1. returns time in format h:m:s
hms::hms(3600)
typeof(hms::hms(3600))
attributes(hms::hms(3600))

# 2. tibbles have to have columns of same length or it gives an error

# 3. I'd assume that as long as the list has the correct number of values, it
# should be fine

################################# 21.2.1 #######################################

# 1. 
output = vector("double", ncol(mtcars))
for (i in seq_along(mtcars)) {
  output[[i]] <- mean(mtcars[[i]])
}
output

output2 = vector("list", ncol(nycflights13::flights))
for (i in seq_along(nycflights13::flights)) {
  output2[[i]] <- class(nycflights13::flights[[i]])
}
output2

output3 = vector("double", ncol(iris))
for (i in seq_along(iris)) {
  output3[i] = n_distinct(iris[i])
}
output3


################################# 21.3.5 #######################################

# 1. 
files <- dir("data/", pattern = "\\.csv$", full.names = TRUE)
file_list = vector("list", length(files))
names(file_list) = files
for (file_name in files) {
  file_list[[file_name]] = read_csv(file_name)
}
file_list

# 2. if there are no names it won't run the loop; missing names throws an error; 
# having the same name just returns the first instance


################################# 21.5.3 #######################################

# 1. 
map_dbl(mtcars, mean)
map_chr(nycflights13::flights, typeof)
map_dbl(iris, n_distinct)

# 2. 
map_lgl(diamonds, is.factor)

# 3. map will run on each element of the vector; exports a list for each 
# indices of the vector
map(1:5, runif)

# 4.
map(-2:2, rnorm, n = 5) # pulls five samples from range of -2:2 at same SD
map_dbl(-2:2, rnorm, n = 5) # throws an error, input has to be same as result


################################### EOF ########################################
