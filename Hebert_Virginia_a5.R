# Title:  Assignment 5
# Purpose:  In book exercises
# Author: Virginia Hebert
# Date: Nov 18, 2021
# Contact Info: vaelswick@yahoo.com
# Notes: complete in-book exercises for Ch 10-16

############################# R for Data Science ###############################

# RUN FOR EVERY SCRIPT INSTANCE

# install.packages("tidyverse")
# install.packages("nycflights13")
# install.packages("ggstance")
# install.packages("lvplot")
# install.packages("ggbeeswarm")
install.packages("lubridate")
library(tidyverse)
library(nycflights13)
library(ggstance)
library(lvplot)
library(ggbeeswarm)
library(ggplot2)
library(lubridate)


################################## 10.5 ########################################

# 1. a tibble only prints the first ten rows and includes a info row with data
# types
mtcars
as_tibble(mtcars)
is_tibble(mtcars)
is_tibble(flights)

# 2. 
df <- data.frame(abc = 1, xyz = "a")
df$x  # returns anything that starts with x
df[, "xyz"]  # returns a variable
df[, c("abc", "xyz")]  # returns a dataframe

df_tibble = as_tibble(df)
df_tibble$x  # no column x in a tibble
df_tibble[, "xyz"]
df_tibble[, c("abc", "xyz")]  # returns a dataframe with the datatype

# 5. converst to a dataframe
var = c(1:4,1:5)
tibble::enframe(var)


################################# 11.2.2 #######################################

# 1. read_delim(file_name, delim = "|")

# 2. read_csv and read_tsv appear to be the same except one is for commas and
# the others is for tab delimited

# 3. read_fwf (fixed width file) needs the file path/name and column position

# 4. quote = 

# 5. 
read_csv("a,b\n1,2,3\n4,5,6") # two column headers, three columns of data
read_csv("a,b,c\n1,2\n1,2,3,4") # irregular amount of data for the columns
read_csv("a,b\n\"1") # funky quotes
read_csv("a,b\n1,2\na,b") # more funky quotes
read_csv("a;b\n1;3") # not comma delimited


################################## 11.3.5 ######################################

# 1. date_names and formats are the most important
?locale

# 2. making them the same throws an error; setting one one way, sets the other
# to the other character, automatically

# 3. date_format and time_format allow you to assign custom formats for reading
# dates and times

# 5. read_csv is for comma delimited, read_csv2 is for semicolon delimited

# 7. 
d1 <- "January 1, 2010" 
parse_date(d1, "%B %d, %Y")
d2 <- "2015-Mar-07" 
parse_date(d2, "%Y-%b-%d")
d3 <- "06-Jun-2017" 
parse_date(d3, "%d-%b-%Y")
d4 <- c("August 19 (2015)", "July 1 (2015)") 
parse_date(d4, "%B %d (%Y)")
d5 <- "12/30/14" # Dec 30, 2014 
parse_date(d5, "%m/%d/%y")
t1 <- "1705" 
parse_time(t1, "%H%M")
t2 <- "11:15:10.12 PM" 
parse_time(t2, "%H:%M:%OS %p")


################################## 12.2.1 ######################################

# 2. 
table2
table4a
table4b
table2_cases = filter(table2, type == "cases") %>%
  rename(cases = count)
table2_cases
table2_pop = filter(table2, type == "population") %>%
  rename(population = count)
table2_pop
table2_combo = tibble(year = table2_cases$year,
                      country = table2_cases$country,
                      cases = table2_cases$cases,
                      population = table2_pop$population) %>%
  mutate(cases_per_pop = (cases / population) * 1000) 
table2_combo
table4c = tibble(country = table4a$country,
                 '1999' = table4a[['1999']] / table4b[['1999']] * 10000,
                 '2000' = table4a[['2000']] / table4b[['2000']] * 10000)
table4c

# 3. 
ggplot(table2_cases, aes(year, cases)) + 
  geom_line(aes(group = country), colour = "grey50") + 
  geom_point(aes(colour = country))


################################## 12.3.3 ######################################

# 2. need quotes around 1999 and 2000
table4a
table4a %>% 
  pivot_longer(c(1999, 2000), names_to = "year", values_to = "cases")

# 3. can't do it b/c there are more than one value for Phillip's age
people <- tribble(
  ~name,             ~names,  ~values,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156)
pivot_wider(people, names_from = 'names', values_from = 'values')

# 4. 
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12)
pivot_longer(preg,c('female','male'), names_to = "sex", values_to = "count")


################################## 12.4.3 ######################################

# 1. extra determines what happens if there are extra characters, fill 
# determines what happens if there are not enough
?separate
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra="drop")
tibble(x = c("a,b,c", "d,e", "f,g,i")) %>% 
  separate(x, c("one", "two", "three"), fill="warn")

# 2. remove takes out the column(s) at are either separated or united, set it
# to false to keep the columns


################################## 13.2.1 ######################################

# 2. airports(f)aa to weather(origin)
weather
airports

# 3. if weather had data for all airports, it would have destinations too

# 4. a new table with the special dates as year, month and day as primary key
# could connect to the flights and weather tables


################################## 13.3.1 ######################################

# 1. 
flights %>% unite(flight_id, carrier, flight, sched_dep_time, 
                  sep="-", remove=FALSE) 


################################## 13.4.6 ######################################

# 1. 
airports
airports %>%
  semi_join(flights, c("faa" = "dest")) %>%
  ggplot(aes(lon, lat)) +
  borders("state") +
  geom_point() +
  coord_quickmap()
delays = flights %>% group_by(dest) %>%
  summarise(delay = mean(arr_delay, na.rm=TRUE)) %>%
  inner_join(airports, by = c(dest="faa"))
delays %>% ggplot(aes(lon, lat, color=delay)) +
  borders("state") +
  geom_point() +
  coord_quickmap()

# 2. 
airport_coords = airports %>% select(faa, lat, lon)
airport_coords
flights %>% select(year:day, hour, origin, dest) %>%
  left_join(airport_coords, by = c("origin" = "faa")) %>%
              left_join(airport_coords, by = c("dest" = "faa"),
                        suffix = c("_origin","_dest"))

# 3. 
planes
flights
flight_delay = inner_join(flights, select(planes, tailnum, plane_year = year),
                          by = "tailnum") %>%
  mutate(age = year - plane_year) %>% group_by(age) %>%
  summarise(dep_delay_avg = mean(dep_delay, na.rm=TRUE))
flight_delay
ggplot(flight_delay, aes(x = age, y = dep_delay_avg)) + 
  geom_point()

# 4. 
weather
flights
flight_weather = flights %>% inner_join(weather, by = c("origin" = "origin",
                                                        "year" = "year",
                                                        "month" = "month",
                                                        "day" = "day",
                                                        "hour" = "hour"))
flight_weather %>% group_by(pressure) %>%
  summarise(delay = mean(dep_delay, na.rm=TRUE)) %>%
  ggplot(aes(x=pressure, y=delay)) +
  geom_point()

# 5. 
June13_flights = filter(flights, year==2013, month==6, day==13) %>%
  group_by(dest) %>%
  summarise(delay = mean(arr_delay, na.rm=TRUE)) %>%
  inner_join(airports, by = c("dest" = "faa")) %>% 
  ggplot(aes(lon, lat, size=delay, color=delay)) +
  borders("state") +
  geom_point() +
  coord_quickmap()
June13_flights


################################## 16.2.4 ######################################

# 1. the non-date returns NA
ymd(c("2010-10-10", "bananas"))

# 2. tzone used to specify the timezone
?today

# 3. 
d1 <- "January 1, 2010"
mdy(d1)
d2 <- "2015-Mar-07"
ymd(d2)
d3 <- "06-Jun-2017"
dmy(d3)
d4 <- c("August 19 (2015)", "July 1 (2015)")
mdy(d4)
d5 <- "12/30/14" # Dec 30, 2014
mdy(d5)

################################## 16.3.4 ######################################

# 1. 
make_datetime_100 <- function(year, month, day, time) {
  make_datetime(year, month, day, time %/% 100, time %% 100)
}

flights_dt <- flights %>% 
  filter(!is.na(dep_time), !is.na(arr_time)) %>% 
  mutate(
    dep_time = make_datetime_100(year, month, day, dep_time),
    arr_time = make_datetime_100(year, month, day, arr_time),
    sched_dep_time = make_datetime_100(year, month, day, sched_dep_time),
    sched_arr_time = make_datetime_100(year, month, day, sched_arr_time)
  ) %>% 
  select(origin, dest, ends_with("delay"), ends_with("time"))
flights_dt
?yday
flights_dt %>% filter(!is.na(dep_time)) %>%
  mutate(dep_hour = update(dep_time, yday = 1)) %>%
  mutate(month = factor(month(dep_time))) %>%
  ggplot(aes(dep_hour, color = month)) + geom_freqpoly(binwidth = 60*60)

# 2. dep_time-schd_dep_time=dep_delay

# 3. air_time is the time in air, with the time change across zones factored in

# 4. dep_time will accumulate delays as the day progresses - use sched_dep_time
flights_dt %>% tibble::as_tibble() %>% print(n=40)
flights_dt %>%
  mutate(sched_dep_hour = hour(sched_dep_time)) %>%
  group_by(sched_dep_hour) %>%
  summarise(dep_delay = mean(dep_delay)) %>%
  ggplot(aes(y = dep_delay, x = sched_dep_hour)) +
  geom_point() + geom_smooth()

# 5. Saturday
flights_dt %>%
  mutate(dow = wday(sched_dep_time)) %>%
  group_by(dow) %>%
  summarise(
    dep_delay = mean(dep_delay),
    arr_delay = mean(arr_delay, na.rm = TRUE)
  )

# 6. regular spikes in count for both datasets
ggplot(diamonds, aes(x = carat)) +
  geom_histogram()
ggplot(flights_dt, aes(x = minute(sched_dep_time))) +
  geom_histogram()

# 7. 
flights_dt %>% 
  mutate(minute = minute(dep_time), early = dep_delay < 0) %>% 
  group_by(minute) %>% 
  summarise(early = mean(early)) %>% 
  ggplot(aes(minute, early)) + geom_line()


################################### EOF ########################################
