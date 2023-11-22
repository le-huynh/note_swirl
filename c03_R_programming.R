# https://www.ling.upenn.edu/~joseff/rstudy/index.html


# Lesson 9: Functions #---------------
#input to function -> called -> argument
#providing arguments to a function -> called -> passing arguments to function

# function_name <- function(arg1, arg2){
#	# Manipulate arguments in some way
#	# Return a value
# }

# increment <- function(number, by = 1){
          # "by = 1" is default value
#     number + by
# }

# see a function's arguments
args(func_name)


# passing a function as an argument
evaluate <- function(func, dat){
  func(dat)
}

> evaluate(function(x){x+1},6)
[1] 7

> evaluate(function(x){x[1]},c(8,4,0))           #return first element of vector
[1] 8

> evaluate(function(x){x[length(x)]},c(8,4,0))   #return last element of vector
[1] 0

# ellipses_func(arg1, arg2 = TRUE, ...) 
# ellipses '...' allows an indefinite number of arguments to be passed into a function

paste (..., sep = " ", collapse = NULL)
#all arguments after an ellipses must have default values

telegram <- function(...){
  paste("START",...,"STOP")
}


# add_alpha_and_beta <- function(...){
#   # First we must capture the ellipsis inside of a list
#   # and then assign the list to a variable. Let's name this
#   # variable `args`.
#
#   args <- list(...)
#
#   # We're now going to assume that there are two named arguments within args
#   # with the names `alpha` and `beta.` We can extract named arguments from
#   # the args list by using the name of the argument and double brackets. The
#   # `args` variable is just a regular list after all!
#   
#   alpha <- args[["alpha"]]
#   beta  <- args[["beta"]]
#
#   # Then we return the sum of alpha and beta.
#
#   alpha + beta 
# }


mad_libs <- function(...){
  args <- list(...)
  place <- args[[1]]
  adjective <- args[[2]]
  noun <- args[[3]]
  paste("News from", place, "today where", adjective, "students took to the streets in protest of the new", noun, "being installed on campus.")
}

# User-defined binary operators have the following syntax:
#      %[whatever]% 
# where [whatever] represents any valid variable name.


"%p%" <- function(...){
  paste(...) 
}

> "I" %p% "love" %p% "R!"
[1] "I love R!"

## control structures <- used to write function
# if-else: testing a condition
# for    : execute a loop a fixed number of times
# while  : ______________ while a condition = TRUE
# repeat : _______ an infinite loop
# break  : break execution of a loop 
# next   : skip an interaction of a loop
# return : exit a function

if (condition) {
  ## do sth
} else {
  ## do sth else
}

if (condition) {
  ## do sth
} else if (condition2) {
  ## do sth different
} else {
  ## do sth different
}

# Lesson 10: tapply + sapply #----------------
# 'The Split-Apply-Combine Strategy for Data Analysis'
# Author: Hadley Wickham
# Journal of Statistical Software

# *apply family functions 
# ->  SPLIT up some data into smaller pieces
# ->  APPLY a function to each piece
# ->  COMBINE the results

lapply(list, function)  #l-apply = 'list'-apply        # result = list: every element is a vector
sapply(list, function)  #s-apply = 'simplify'-apply    # if result = a list (every element of length one) -> sapply result = vector
                                                       # ________________________________same length (>1) -> _____________ = matrix
                                                       # if result = sapply cant figure out               -> _____________ = list = lapply result

> lapply(flag_colors,sum)
$red
[1] 153

$green
[1] 91

$blue
[1] 99

$gold
[1] 91

$white
[1] 146

$black
[1] 52

$orange
[1] 26

> sapply(flag_colors,sum)
red  green   blue   gold  white  black orange 
153     91     99     91    146     52     26 

range()  # minimum + maximum of all given arguments
unique() # returns a vector/data frame/array like x but with duplicate elements/rows removed

# Lesson 11: Vapply + tapply #----------------------

# s-apply -> 'guess' correct format of result
# v-apply -> If the result doesn't match the format you specify, vapply() -> throw an error, causing the operation to stop. This can
# prevent significant problems in your code that might be caused by getting unexpected return values from sapply().

> vapply(flags, class, character(1)) 
#'character(1)' -> expect the class function to return a character vector of length 1 when applied to EACH column of the flags dataset

# t-apply -> split data up into groups based on the value of some variable, then apply a function to the members of each group.

> table(flags$landmass)
1  2  3  4  5  6 
31 17 35 52 39 20 
> table(flags$animate)
0   1 
155  39 
> tapply(flags$animate,flags$landmass, mean) 
1         2         3         4         5         6 
0.4193548 0.1764706 0.1142857 0.1346154 0.1538462 0.3000000 
#proportion of flags containing an animate image WITHIN each landmass group



# Lesson 13: Simulation #--------------------
# generate random numbers
sample()
sample(1:6, 4, replace = TRUE) #randomly select 4 numbers between 1 and 6, with replacement

flips <- sample(c(0,1),100, replace = TRUE, prob = c(0.3,0.7))
# simulate 100 flips of an unfair two-sided coin. 
# coin has a 0.3 probability of landing 'tails'(0) and a 0.7 probability of landing 'heads'(1)

set.seed()

# Each probability distribution in R has:
# + r*** function (for "random")
# + d***          ("density")
# + p***          ("probability")
# + q***          ("quantile")

rbinom() #simulate binomial random variable
rbinom(1, size = 100, prob = 0.7)   #simulate ONLY probability of 'success' (head=1), NOT 'failure' (tail=0)
rbinom(n = 100,size = 1,prob = 0.7) #100 observations, each of size 1, success probability of 0.7

rnorm()
rpois()

replicate()
# apply a function over a List/ Vector
# create a matrix

colMeans() # return mean of each column in data frames

hist()     # plot histogram

# Lesson 14: Dates + Times #--------------------
## important: 'lubridate' package by Hadley Wickham

#useful with time-series data
# Date -> 'Date' class
# Time -> 'POSIXct' class -> number of seconds since the 1970-1-1 (UTC time zone) = numeric vector
#      -> 'POSIXlt' class -> list of seconds, minutes, hours, etc.

unclass()

as.Date("1969-01-01")   #create date before 1970-01-01

as.POSIXlt()

str(unclass())

weekdays()
months()
quarters()

strptime()  #converts character vectors to POSIXlt = as.POSIXlt()

t3 <- "October 17, 1986 08:24"
t4 <- strptime(t3, "%B %d, %Y %H:%M")
> t4
[1] "1986-10-17 08:24:00 PDT"

> Sys.time() > t1
[1] TRUE
> Sys.time() - t1
Time difference of 13.09717 mins

> difftime(Sys.time(), t1, units = 'days')  #find the amount of time in DAYS that has passed since t1 was created.
Time difference of 0.01103487 days



# Lesson 15: Base Graphics #-------------------
# advanced graphics in R: package 'lattice' - 'ggplot2' - 'ggvis'

plot() #short for 'scatterplot'
par()  #MORE graphical options

boxplot()

hist()

# https://www.ling.upenn.edu/~joseff/rstudy/week4.html


### DEBUGGING TOOL
## Diagnosing the problem
# message
# warning
# error
# condition

## Debugging Tool:
traceback()  #print out function call stack after error occur
debug()      #[???]
browser()    
trace()
recover()


### R PROFILER
# profiling = systematic way -> examine how much time is spend for different parts of a program
# useful -> optimize the code

system.time()
Rprof()         # start profiler in R
## NEVER use system.time() and Rprof() together

summaryRprof()  # summarize output from Rprof()
# 'by.total'              = divide the time spend in each function by the total run time
# 'by.self' [recommended] = subtract out time spend in function above -> divide_____run time 






