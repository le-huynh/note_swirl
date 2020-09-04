### Lesson 1: Manipulating Data with dplyr

library(dplyr)
packageVersion("dplyr")
cran <- tbl_df(mydf)  #load data into 'data frame tbl'/'tbl_df' (in package language)

select()
filter()
arrange()
mutate()     #create a new variable based on the value of one or more variables already in a dataset
summarize()  #collapse dataset to a single row

select(cran, ip_id, package, country) # = cran$ip_id + cran$package + cran$country
select(cran, r_arch:country)          # select all columns starting from r_arch, ending with country
select(cran, -time)                   # select all column + omit 'time' column
select(cran, -(X:size))               # omit columns from 'X' to 'size'

filter(cran, package == "swirl")                    # select all rows for which the 'package' variable = "swirl"
filter(cran, r_version <= "3.1.1", country == "US") # AND
filter(cran, country == "US" | country == "IN")     # OR: 'country' = either "US" or "IN"
filter(cran, !is.na(r_version))                     # 'r_version' # NA

cran2 <- select(cran, size:ip_id)
arrange(cran2, ip_id)             #order the ROWS of cran2 => ip_id = ascending order (small-> large)
arrange(cran2, desc(ip_id))       #_________________________________= descending ____ 
arrange(cran2, package, ip_id)    # arrange package names (ascending alphabetically) -> ip_id (ascending numerically)
arrange(cran2, country, desc(r_version), ip_id)

mutate(cran3, size_mb = size / 2^20)                           #add 'size_mb' column into dataset
mutate(cran3, size_mb = size / 2^20, size_gb = size_mb/2^10)   #add 2 new columns  

summarize(cran, avg_bytes = mean(size))  #mean value of the 'size' varialbe -> single number


### Lesson 2: Grouping + Chaining (dplyr)

group_by() #break up dataset into groups of rows based on values of 1 / more variables

by_package <- group_by(cran,package)  #Group 'cran' by 'package' variable
summarize(by_package,mean(size))      #mean 'size' for EACH package in dataset
# A tibble: 6,023 x 2
package     `mean(size)`
<chr>              <dbl>
1 A3                62195.
2 abc             4826665 
3 abcdeFBA         455980.
4 ABCExtremes       22904.
5 ABCoptim          17807.
6 ABCp2             30473.
7 abctools        2589394 
8 abd              453631.
9 abf2              35693.
10 abind             32939.
# ... with 6,013 more rows

pack_sum <- summarize(by_package,
                      count = n(),                      #total number of rows (i.e. downloads) for each package
                      unique = n_distinct(ip_id),       #total number of unique downloads for each package = number of distinct ip_id's
                      countries = n_distinct(country) , #number of countries in which each package was downloaded
                      avg_bytes = mean(size))           #mean download size (in bytes) for each package

quantile(pack_sum$count, probs = 0.99)  #value of 'count' that splits data -> top 1% - bottom 99% of packages based on total downloads
99% 
679.56

top_counts <- filter(pack_sum,count > 679)

View()

# "%>%" chaining: code to the right of %>% operates on the result from the code to the left of %>%

# ----Eg.1--------------
by_package <- group_by(cran, package)
pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))

top_countries <- filter(pack_sum, countries > 60)
result1 <- arrange(top_countries, desc(countries), avg_bytes)

print(result1)

# -----Eg.2--------------
result2 <-
  arrange(
    filter(
      summarize(
        group_by(cran,
                 package
        ),
        count = n(),
        unique = n_distinct(ip_id),
        countries = n_distinct(country),
        avg_bytes = mean(size)
      ),
      countries > 60
    ),
    desc(countries),
    avg_bytes
  )

print(result2)


# -----Eg.3---------
result3 <-
  cran %>%
  group_by(package) %>%
  summarize(count = n(),
            unique = n_distinct(ip_id),
            countries = n_distinct(country),
            avg_bytes = mean(size)
  ) %>%
  filter(countries > 60) %>%
  arrange(desc(countries), avg_bytes)

print(result3)

#---- Eg. ----
cran %>%
  select(ip_id, country, package, size) %>%
  mutate(size_mb = size / 2^20) %>%
  filter(size_mb <= 0.5) %>%
  arrange(desc(size_mb)) %>%
  print()



### Lesson 3: Tidying Data with tidyr
# paper 'Tidy Data' - Hadley Wickham
#http://vita.had.co.nz/papers/tidy-data.pdf


# Tidy data:
#1) Each variable forms a column
#2) Each observation forms a row
#3) Each type of observational unit forms a table

# 'tidyr' package

gather()
gather(students,sex,count,-grade) 
# data = 'students', gather all columns EXCEPT 'grade'

#The data argument, students, gives the name of the original dataset. 
# The key and value arguments -- sex and count, respectively -- give the column names for our tidy dataset. 
#The final argument, -grade, says that we want to gather all columns EXCEPT the grade column (since grade is already a proper column variable.)

#---Eg.-----
> students2
grade male_1 female_1 male_2 female_2
1     A      7        0      5        8
2     B      4        0      5        8
3     C      7        4      5        6
4     D      8        2      8        1
5     E      8        4      1        0

res <- gather(students2,sex_class,count,-grade)
separate(res,sex_class,c("sex","class"))

#---Eg.1----
students2 %>%
  gather(sex_class,count,-grade ) %>%
  separate(sex_class , c("sex", "class")) %>%
  print()

#---Eg----
students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  spread(test, grade) %>%
  mutate(class = parse_number(class)) %>%
  print()

parse_number()

#---Eg.-------
student_info <- students4 %>%
  select(id, name, sex) %>%
  unique() %>%
  print

#---Eg----
passed <- passed %>% mutate(status = "passed")
failed <- failed %>% mutate(status = "failed")
bind_rows(passed, failed)

#---Eg.------
sat %>%
  select(-contains("total")) %>%
  gather(part_sex, count, -score_range) %>%
  separate(part_sex, c("part", "sex")) %>%
  group_by(part,sex) %>%
  mutate(total = sum(count), prop = count/total) %>% 
  print



### Lesson 4: Dates and Times with 'lubridate'
Sys.getlocale("LC_TIME")
help(package = lubridate)

this_day <- today()
year()
month()
day()
wday()  #the day of the week: 1=Sunday, 2 = Monday, 3 = Tuesday, etc.

wday(this_day, label = TRUE)
[1] Tue
Levels: Sun < Mon < Tue < Wed < Thu < Fri < Sat

now()  #returns the date-time representing this exact moment in time
hour()
minute()
second()

ymd() #input = "character" string -> output = class POSIXct
dmy()
hms()
ymd_hms()

> ymd("1989 May 17")
[1] "1989-05-17"
> mdy("March 12, 1975")
[1] "1975-03-12"
> dmy(25081985)
[1] "1985-08-25"

update(this_moment, hours = 8, minutes = 34, seconds = 55)

nyc <- now("America/New_York") #timezone in New York
#valid time zones for use with lubridate: http://en.wikipedia.org/wiki/List_of_tz_database_time_zones

> nyc
[1] "2019-08-27 18:16:07 EDT"
> depart <- nyc + days(2)
> depart
[1] "2019-08-29 18:16:07 EDT"

with_tz()  #Get date-time in a different time zone
with_tz(data,"Asia/Hong_Kong")


last_time <- mdy("June 17, 2008",tz="Singapore")
how_long <- interval(last_time,arrive)
as.period(how_long)
[1] "11y 2m 13d 21H 24M 7S"

#Paper: "'Dates and Times Made Easy with lubridate'
#Journal: 2011 Journal of Statistical Software

