# Title:  Assignment 4
# Purpose:  In book exercises
# Author: Virginia Hebert
# Date: Oct 29, 2021
# Contact Info: vaelswick@yahoo.com
# Notes: compelete in-book exercises for Ch 1-6

############################# R for Data Science ###############################

# RUN FOR EVERY SCRIPT INSTANCE

# install.packages("tidyverse")
# install.packages("nycflights13")
# install.packages("ggstance")
# install.packages("lvplot")
# install.packages("ggbeeswarm")
library(tidyverse)
library(nycflights13)
library(ggstance)
library(lvplot)
library(ggbeeswarm)


################################## 3.2.4 #######################################

# 1. mpg is a dataframe with car information
# 2. 234 rows in the mpg dataset, 11 columns
# 3. drv is the type of drivetrain
mpg
?mpg

# 4. scatterplot of the hwy vs cyl
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = cyl, y = hwy))

# 5. scatterplot of the class vs drv - not useful b/c one is not dependent on 
# the other
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = class, y = drv))


################################## 3.3.1 #######################################

# 1. the points are not blue b/c they are inside the aes parentheses
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))

# 2. the categorical variables (manufacturer, model, transmission, drive, fuel 
# type, class) contain characters and the continuous variables (displacement, 
# year, cylinders, city mpg, highway mpg) are numeric

# 3. continuous variable to color, size or shape will change gradationally based 
# on the aesthetic based on the value
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = year))

# 3. categorical variable to color, size or shape will be fit into distinct
# buckets
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = trans))

# 4. same continuous variable to shape throws an error
# same categorical variable to size throws an error
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = year, size = year,
                           shape = year))
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = drv, size = drv,
                           shape = drv))

# 5. stroke aesthetic is the thickness of the line of a filled shapes (square, 
# circle, triangle, diamond)
?geom_point
vignette("ggplot2-specs")

# 6. mapping to something other than a variable turns it into a boolean 
# operation
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))


################################## 3.5.1 #######################################

# 1. faceting on a continuous variable creates a panel for each value in the 
# dataset
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = cyl)) + 
  facet_wrap(~ hwy, nrow = 4)

# 2. the empty cells in facet_grid(drv ~ cyl) indicate there were no values that 
# had both variables in the cell 
# in the plot below, because the values are discrete and low value, they 
# correspond exactly at intersections
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))

# 3. the . puts no variable along whatever axis it is in place of in the facet
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

# 4. faceting instead of other aesthetics would be good to compare trends 
# between variables; if there were a large dataset, the number of plots would be 
# over-whelming and value would be lost
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

# 5. nrow = number of rows, ncol = number of columns
# facet_grid() doesn't have rows and columns b/c it is based on the variables
?facet_wrap

# 6. the variable with the more unique levels in columns to preserve the scale 
# of they y-axis


################################## 3.6.1 #######################################

# 1. geom_smooth for line, geom_boxplot, geom_histogram, geom_area

# 2. point and line chart of highway mileage vs displacement, colored by drive
# train
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

# 3. show.legend = FALSE removes the legend from the plot; used it earlier to 
# make the plots consistent
ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = TRUE)

# 4. se argument in geom_smooth turns on and off the confidence level buffer
# around the line

# 5. they look the same because the graph layout and inputs are the same
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# 6. 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth(se = FALSE)
ggplot(data = mpg) +
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv), se = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)
ggplot(data = mpg) +
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_smooth(mapping = aes(x = displ, y = hwy), se = FALSE)
ggplot(data = mpg) +
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv), se = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = drv)) + 
  geom_point(shape = 21, color = "white", stroke = 3, size = 4)


################################## 3.7.1 #######################################

diamonds

# 1. stat_summary uses geom_pointrange
ggplot(data = diamonds) +
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median)
ggplot(data = diamonds) +
  geom_pointrange(mapping = aes(x = cut, y = depth),
                  stat = "summary",
                  fun.min = min,
                  fun.max = max,
                  fun = median)

# 2. geom_col has two variables, geom_bar has one variable and counts it

# 3. each stat and geom have the same name, just preceded by stat_ or geom_

# 4. stat_smooth calculates x/y, x/ymin, x/ymax, or standard error; controlled 
# by method, formula, se, na.rm, span, method.args
?stat_smooth

# 5. without the group = 1, the proportions are calculating within each group, 
# so they will all equal one


################################## 3.8.1 #######################################

# 1. the points in the plot are plotting on top of one another - use the jitter
# position to view all the data points available

# 2. width and height control the amount of jitter
?geom_jitter

# 3. geom_jitter slightly moves the points, so they don't overlap - technically
# changing their values somewhat; geom_count resizes the points to account for
# the overlap
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_count()
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_jitter()

# 4. the default position for geom_boxplot is dodge2 - adjusts the horizontal 
# position but adjusts the vertical position
?geom_boxplot
?position_dodge2
ggplot(data = mpg, mapping = aes(x = trans, y = hwy, color = drv)) + 
  geom_boxplot()


################################## 3.9.1 #######################################

# 1. 
bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

# 2. labs() adds titles and labels to your plot
?labs

# 3. coord_quickmap approximately and quickly sets the aspect ratio for the 
# map you are making.  coord_map does an actual projection and takes longer.

# 4. the plot tells you that the higher the highway mpg, the higher the city
# mpg at an almost one to one ratio.  coord_fixed scales the plot so the ratio
# is apparent.
?coord_fixed


################################### 4.4 ########################################

# 1. the i in the my_variable that is being called is not correct

# 2. 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
filter(mpg, cyl == 8)
filter(diamonds, carat > 3)

# 3. Windows + Shift + K 
#    Tools -> Keyboard Shortcut Help


################################## 5.2.4 #######################################

flights

# 1. 
filter(flights, dep_delay >= 2)
filter(flights, dest == "IAH" | dest == "HOU")
filter(flights, carrier == "UA" | carrier == "AA" | carrier == "DL")
filter(flights, month == 7 | month == 8 | month == 9)
filter(flights, arr_delay >= 120 & dep_delay <= 0)
filter(flights, dep_delay >= 60 & dep_delay - arr_delay > 30)
filter(flights, dep_time <= 600 | dep_time == 2400)

# 2. Could use between() to filter on the flight times and months

# 3. NA departure time is likely canceled flights as they are also missing
# arrival info and air time
filter(flights, is.na(dep_time))

# 4. NA in the first three instances can result in a true statement or value,
# in NA * 0 it doesn't always
NA ^ 0
NA | TRUE
FALSE & NA
NA * 0


################################## 5.4.1 #######################################

# 1. 
select(flights, dep_time, dep_delay, arr_time, arr_delay)
flight_info <- c("dep_time","dep_delay","arr_time","arr_delay")
select(flights, flight_info)

# 2. if you include a variable twice in select() it ignores it

# 3. will return a row that has any of the columns in the variable
vars <- c("year", "month", "day", "dep_delay", "arr_delay")
select(flights, any_of(vars))

# 4. case doesn't matter in select(); use ignore.case = FALSE to make it matter
select(flights, contains("TIME"))


################################## 5.5.2 #######################################

flights

# 1. 
flight_min <- mutate(flights, 
    dep_time_min = (dep_time %/% 100 * 60 + dep_time %% 100) %% 1440, 
    sched_dep_time_min = (sched_dep_time %/% 100 * 60 + sched_dep_time %% 100
                      %% 1440))
select(flight_min, dep_time, dep_time_min, sched_dep_time, sched_dep_time_min)

# 2. air_time should equal arr_time - dep_time but doesn't - variations could be
# because the flight is over midnight or crosses time zones, messing with the
# calculations
flights_airtime <- mutate(flights,
         dep_time = (dep_time %/% 100 * 60 + dep_time %% 100) %% 1440,
         arr_time = (arr_time %/% 100 * 60 + arr_time %% 100) %% 1440,
         air_time_diff = air_time - arr_time + dep_time)
filter(flights_airtime, air_time_diff != 0)

# 3. dep_delay should be dep_time - sched_dep_time
select(flights, dep_time, sched_dep_time, dep_delay)

# 4. 
?min_rank
flights_delayed <- mutate(flights, 
                           dep_delay_min_rank = min_rank(desc(dep_delay)))
flights_delayed <- filter(flights_delayed, !(dep_delay_min_rank > 10))   
flights_delayed <- arrange(flights_delayed, dep_delay_min_rank)
select(flights_delayed, dep_delay, dep_delay_min_rank)
                                                

################################## 5.6.7 #######################################

# 1. 

# 2.
not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))
not_cancelled %>% count(dest)
not_cancelled %>% count(tailnum, wt = distance)

not_cancelled %>%
  group_by(dest) %>%
  summarise(n = length(dest))
not_cancelled %>%
  group_by(tailnum) %>%
  tally()

# 3. the definition given doesn't take into account flights that were diverted;
# so, arr_delay would give the best indication if the flight were actually
# cancelled

# 4. number of canceled flights increases with the number of flights and the 
# longer the delays, the more cancels
cancels_per_day <- 
  flights %>%
  mutate(cancelled = (is.na(arr_delay) | is.na(dep_delay))) %>%
  group_by(year, month, day) %>%
  summarise(cancelled_num = sum(cancelled), flights_num = n(),)
ggplot(cancels_per_day) +
  geom_point(aes(x = flights_num, y = cancelled_num)) 

# 5. Frontier Airlines had the worse delays
flights %>%
  group_by(carrier) %>%
  summarise(arr_delay = mean(arr_delay, na.rm = TRUE)) %>%
  arrange(desc(arr_delay))
filter(airlines, carrier == "F9")

# 6. sort would place the largest groups at the top of the list if TRUE
?count()


################################## 5.7.1 #######################################

# 1. using group_by() with certain functions causes the function to be run on 
# the group; group_by() doesn't work on arithmetic and logical functions

# 2. 
flights %>%
  filter(arr_delay > 0) %>%
  group_by(tailnum) %>%
  count(tailnum) %>%
  arrange(desc(n))


################################## 7.3.4 #######################################

diamonds

# 1. z is the height, and x and y are the cross dimensions
summary(select(diamonds, x, y, z))

# 2. there are no diamonds with a price around $1500
summary(select(diamonds, price))
ggplot(filter(diamonds, price < 2000), aes(x = price)) + 
  geom_histogram(binwidth = 25)

# 3. there are magnitudes more 1 carat than 0.99 carat diamonds
diamonds %>% filter(carat >= 0.99, carat <= 1) %>%
  count(carat)

# 4. coord_cartesian(xlim, ylim) zooms in after things are calculated, xlim() 
# and ylim() limit the values that go into the calculations/plot; leaving 
# binwidth unset throws an error
ggplot(diamonds) +
  geom_histogram(mapping = aes(x = price), binwidth = 1000) +
  coord_cartesian(xlim = c(0, 10000), ylim = c(0, 10000))
ggplot(diamonds) +
  geom_histogram(mapping = aes(x = price), binwidth = 1000) +
  xlim(0, 10000) + ylim(0, 10000)


################################## 7.4.1 #######################################

# 1. missing values are removed with a warning in a histogram, since it bins
# values; in a bar chart missing values are treated as their own category

# 2. na.rm = TRUE removes NA values before calculating mean() and sum()


################################# 7.5.5.1 ######################################

# 1. 

# 2. size/carat seems to be the best guide to price
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point()
ggplot(diamonds, aes(x = cut, y = price)) +
  geom_boxplot()
ggplot(diamonds, aes(x = color, y = price)) +
  geom_boxplot()
ggplot(diamonds, aes(x = clarity, y = price)) +
  geom_boxplot()

# 3. they look the same, just need to remember to flip the values when using the 
# horizontal plot
ggplot(diamonds) +
  geom_boxplot(mapping = aes(x = clarity, y = price)) + coord_flip()
ggplot(diamonds) +
  geom_boxploth(mapping = aes(y = clarity, x = price))

# 4. the lv plot doesn't stack/hide the outliers that fall out of the box
ggplot(diamonds, aes(x = clarity, y = price)) +
  geom_lv()

# 5. geom_freqpoly is good for assessing a parameter for a value that isn't in 
# the dataset (i.e. look at the price and see what the clarity should be and 
# vice versa); with geom_violin and geom_histogram you can more easily compare
# the distribution of the values to each other
ggplot(data = diamonds, mapping = aes(x = price, y = ..density..)) +
  geom_freqpoly(mapping = aes(color = clarity), binwidth = 500)
ggplot(data = diamonds, mapping = aes(x = clarity, y = price)) +
  geom_violin() +
  coord_flip()

# 6. geom_quasirandom uses van der Corput or Tukey texturing to avoid overlap
# and geom_beeswarm uses the beeswarm library to do point-size offset
?ggbeeswarm


################################# 7.5.2.1 ######################################

# 1. use a heat map style plot
diamonds %>%
  count(color, cut) %>%
  group_by(color) %>%
  mutate(prop = n / sum(n)) %>%
  ggplot(mapping = aes(x = color, y = cut)) +
  geom_tile(mapping = aes(fill = prop))

# 2. using geom_tile with a dataset that has a large number of variables results
# in a plot that is difficult to read b/c the divisions are so small

# 3. putting the variable with longer labels and more categories on the Y axis
# is just better aesthetically, so they don't overlap


################################# 7.5.3.1 ######################################

# 1. for cut_width you need to choose the width and bins will auto-calc, for 
# cut_number you choose the number of bins and the width will auto-calc; need to
# choose the size/number to get a good visualization without too much noise but
# also not hide actual variability

# 2. 
ggplot(diamonds, aes(x = cut_number(price, 10), y = carat)) +
  geom_boxplot() +
  coord_flip() +
  xlab("Price")

# 3. the price of diamonds compared to size is more variable for larger 
# diamonds - makes sense, as there are less large diamonds, causing the other
# factors to influence price more

# 4. 
ggplot(diamonds, aes(x = cut_number(carat, 4), y = price, colour = cut)) +
  geom_boxplot() +
  coord_flip() +
  xlab("carats")

# 5. scatterplot will not lump the outliers into a bin, so they'll be apparent
ggplot(data = diamonds) +
  geom_point(mapping = aes(x = x, y = y)) +
  coord_cartesian(xlim = c(4, 11), ylim = c(4, 11))
ggplot(data = diamonds) + 
  geom_histogram(mapping = aes(x = x), binwidth = 1)


################################### EOF ########################################
