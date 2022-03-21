#https://www.ling.upenn.edu/~joseff/rstudy/index.html

# change R system language into English
Sys.setenv(LANG = "en")

###Lesson 2: Basic Building Blocks 
# assignment operator: <-
# vector = small collection of numbers
# data structure = any object that contains data
# simplest type of data structure = numeric vectors

c() #stand for 'concatenate' / 'combine'
    #create vector
?function_name  #access R's built-in help file
#e.g.:
?c
?`:`

c(z,555,z)
sqrt()  #square root
abs()   #absolute value

#two vectors of same length -> R performs the specified arithmetic operation (`+`, `-`, `*`, etc.) element-by-element. 
#vectors of different lengths -> R 'recycles' the shorter vector until it is the same length as the longer vector.
#e.g. z * 2 + 100 in earlier example, z was a vector of length 3, but technically 2 and 100 are each vectors of length 1
#Behind the scenes, R is 'recycling' the 2 to make a vector of 2s and the 100 to make a vector of 100s. 
#In other words, when you ask R to compute z * 2 + 100, what it really computes is this: z * c(2, 2, 2) + c(100, 100, 100).
c(1,2,3,4) + c(0,10)
[1]  1 12  3 14
c(1,2,3,4) + c(0,10,100)
[1]   1  12 103   4
Warning message:
  In c(1, 2, 3, 4) + c(0, 10, 100) : longer object length is not a multiple of shorter object length

##time-saving tricks
#up arrow
#Tab -> auto-completion

###Lesson 3: Sequences of Numbers
#Aim: how to create sequences of numbers in R

## `:` operator
1:20  #integer
[1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
pi:10 #real number
[1] 3.141593 4.141593 5.141593 6.141593 7.141593 8.141593 9.141593
15:1
[1] 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1

## seq() 
#e.g.:
seq(1, 20)
[1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
seq(0, 10, by=0.5)   #sequence of numbers between 0 and 10, incremented by 0.5
[1]  0.0  0.5  1.0  1.5  2.0  2.5  3.0  3.5  4.0  4.5  5.0  5.5  6.0  6.5  7.0  7.5  8.0  8.5  9.0  9.5 10.0
seq(5, 10, length=30) #sequence of 30 numbers between 5 and 10

## length() #length of a vector

1:length(my_seq)
[1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
seq(along.with=my_seq)
[1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
seq_along(my_seq)
[1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30

## rep()  #`replicate`
rep(0,times=40)           #create vector that contains 40 zeros
[1] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
rep(c(0,1,2),times=10)    #10 repetitions of vector (0,1,2)
[1] 0 1 2 0 1 2 0 1 2 0 1 2 0 1 2 0 1 2 0 1 2 0 1 2 0 1 2 0 1 2  
rep(c(0,1,2), each=10)    #create a vector that contains 10 zeros, then 10 ones, then 10 twos
[1] 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2



###Lesson 4: vectors
##vector:
# + atomic vector: contain exactly 1 data type -> numeric / logical / character / interger / complex
# + list: contain multiple data types

## logical vector:
# + value: TRUE /FALSE / NA
# + logical operator: >, <=, == exact equality, != inequality
# + A|B: or / union -> at least one is TRUE
# + A & B: and / intersection -> both are TRUE
# + !A: negation of A = TRUE when A is FALSE, vice versa

## character vector:
# + "character"
# + paste (): join the elements of my_char together into one continuous character string

my_char <- c("My", "name", "is")
my_char
[1] "My"   "name" "is"  
paste(my_char,collapse = " ")
[1] "My name is"
paste("hello","world!",sep = " ")
[1] "hello world!"
paste(1:3,c("X","Y","Z"),sep = "")
[1] "1X" "2Y" "3Z"
paste(LETTERS,1:4,sep = "-")
[1] "A-1" "B-2" "C-3" "D-4" "E-1" "F-2" "G-3" "H-4" "I-1" "J-2" "K-3" "L-4" "M-1" "N-2" "O-3" "P-4" "Q-1" "R-2" "S-3" "T-4" "U-1" "V-2" "W-3" "X-4" "Y-1" "Z-2"

### Lesson 5:  Missing Data
#NA = not available
#NaN = not a number

sample(data, 100) #randomly select 100 values from "data" 
is.na()           #check whether each element of a vector is NA

my_data == NA
[1] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
#NA not really a value, just a placeholder for a quantity that is not available
# -> logical expression is incomplete -> result = all NA

### Lesson 6: Subsetting Vectors

subset()

## subset -> place 'index vector' in square brackets immediately following the name of vector
x[1:10] #subset first ten elements of x

## 'index vector':
# + logical vectors
# + vectors of positive integers
# + vectors of negative intergers
# + vectors of character strings

## logical vectors:
x[is.na(x)] #result = 1 vector with all NA
x[!is.na(x)]#result contains all non-NA value in x
x[!is.na(x) & x>0]

# "zero-based indexing": first element of a vector is considered element 0
# R uses "one-based indexing"

x[c(3,5,7)]       #subset ONLY element 3rd, 5th, and 7th of x
x[c(-3,-5,-7)]    #subset all elements of x, EXCEPT element 3rd, 5th, and 10th
x[-c(3,5,7)]      #subset all elements of x, EXCEPT element 3rd, 5th, and 10th

>vect <- c(foo = 11, bar = 2, norf =NA)
>vect
foo  bar norf 
11    2   NA 
> names(vect)
[1] "foo"  "bar"  "norf"

vect2 <- c(11,2,NA)
names(vect2) <- c("foo","bar","norf") #add the names attribute to vect2
identical(vect,vect2) #check if 2 vectors are EXACTLY equal

vect["bar"]
vect[c("foo","bar")]

### Lesson 7: Matrix + Dataframe
# used to store tabular data (rows + columns)
# matrix: contain ONLY a single class of data
# dataframe: consist MANY different classes of data

dim() #GET or SET dimensions of/for an object
dim(my_vector)
dim(my_vector) <- c(4,5) #divide 20 elements in my_vector into 4 rows, 5 columns
# my_vector becomes matrix
attributes(my_vector) #same function as dim(my_vector)

class()

matrix() #create matrix

#convert a vector to  matrix
dim(x) <- c(nx, ny)
dimnames(x) <- list(row_names, col_names)

cbind() #combine columns
cbind(x,y) #combine columns x and y into matrix -> single class of data -> R "coerce" numeric value into character = implicit coercion

data.frame(x, y) #store different classes of data (character, number,...)

### Lesson 8: Logic
# && -> AND -> only evaluate first element of 1 vector
> TRUE & c(TRUE, FALSE, FALSE)
[1]  TRUE FALSE FALSE
> TRUE && c(TRUE, FALSE, FALSE)
[1] TRUE

## || -> OR -> only evaluate first element of 1 vector

## AND operator is evaluated before OR

isTRUE()  # TRUE if argument evaluates to TRUE, vice versa
identical()

xor()   #'exclusive OR' -> TRUE if 1 argument is TRUE, 1 is FLASE
xor(5==6,!FALSE) #FALSE, TRUE -> TRUE
[1]TRUE
xor(5==5,!FALSE) #TRUE, TRUE -> FALSE
[1]FALSE

which() #takes a logical vector as an argument -> returns the indices of the vector that are TRUE
any()   #TRUE if one or more of the elements in the logical vector is TRUE
all()   #TRUE if every element in the logical vector is TRUE


### Lesson 9: Workspace + Files

getwd()   #current wroking directory
setwd()   #set working directory
ls()      #list all objects in local workspace
list.files()  #list all files in working directory
dir()         #list all files in working directory

args()    #see what arguments a function can take
> args(list.files)
function (path = ".", pattern = NULL, all.files = FALSE, 
          full.names = FALSE, recursive = FALSE, ignore.case = FALSE, 
          include.dirs = FALSE, no.. = FALSE) 
  NULL

dir.create("dir_name")       #create a directory in current working directory
file.create("file_name.R")   #create a file in current working directory
file.exists("file_name.R")   # TRUE if the file exists in current wd
file.info("file_name.R")     #access file's info

# '$' grab specific items
file.info("mytest.R")$mode

file.rename("old_name.R","new_name.R")
file.copy(from,to)

dir.create(file.path("folder1","folder2"),recursive = TRUE)
#create folder1 in wd, then subdirectory called folder2


### Lesson 10: Reading Tabular Data
# 'readr' package
#Section 1.3 of the book "Mastering Software Development in R"

# use file "urban.csv.gz"
#The directory in which the 'urban.csv.gz' data file is located is saved in an R object called 'datapath'.

print(datapath)
datafile <- file.path(datapath,"urban.csv.gz")
read_csv(datafile)

head()   #display the first few rows of 'urban' data frame

urban <- read_csv(datafile, col_types = "cccdc")
#use compact string "cccdc" to set col_types for each column

urban <- read_csv(datafile, col_types = "cccd-", n_max= 100)
#skip reading the last column
#read only 100 first columns


### Lesson 11: Looking at data
# look at the data before treating it

# What is the format of the data? 
# What are the dimensions? 
# What are the variable names? 
# How are the variables stored? 
# Are there missing data? 
# Are there any flaws in the data?

class()
dim()
nrow()  # see only the number of rows
ncol()  #________________________columns
object.size()  # how much space the dataset is occupying in memory (1GB, 200MG, etc.)
names()        # names of all columns in dataset
head(x,number_of_rows) # first rows
tail(x,number_of_rows) # rows at the end of dataset
summary()              #provides different output for each variable, depending on its class
table(x$x1)  #how many times each value occurs in the data
str()        #combine many of above functions

split()



### Lesson 11: Data Manipulation [??????????]
wc_4 <- worldcup %>% 
  select(Time, Passes, Tackles, Saves) %>%
  summarize(Time = mean(Time),
            Passes = mean(Passes),
            Tackles = mean(Tackles),
            Saves = mean(Saves)) %>%
  gather(var, mean) %>%
  mutate(mean = round(mean, 1))


titanic_4 <- titanic %>% 
  select(Survived, Pclass, Age, Sex) %>%
  filter(!is.na(Age)) %>%
  mutate(agecat = cut(Age, breaks = c(0, 14.99, 50, 150), 
                      include.lowest = TRUE,
                      labels = c("Under 15", "15 to 50",
                                 "Over 50"))) %>%
  group_by(Pclass, agecat, Sex) %>%
  summarize(N = n(),
            survivors = sum(Survived == 1),
            perc_survived = 100 * survivors / N)



### Lesson 13: Text Manipulation Functions
is.character() # TRUE if object is string = character

>paste("Square","Circle","Triangle")
[1] "Square Circle Triangle"

> paste(shapes,collapse = " ")
[1] "Square Circle Triangle"

>paste("Square","Circle","Triangle", sep = "+")
[1] "Square+Circle+Triangle"

> paste0("Square","Circle","Triangle") # Paste0() -> combine string arguments without any character between them
[1] "SquareCircleTriangle"

>shapes <- c("Square","Circle","Triangle")
> paste("My favorite shape is a",shapes)
[1] "My favorite shape is a Square"   "My favorite shape is a Circle"   "My favorite shape is a Triangle"

> nchar("Count Me!") #counts the number of characters in a string
[1] 9

> cases <- c("CAPS","low","Title")
> toupper(cases)
[1] "CAPS"  "LOW"   "TITLE"
> tolower(cases)
[1] "caps"  "low"   "title"


### Lesson 14: Regular Expressions = "regex"
# regular expression = string that defines a pattern that could be contained within another string
# Use: + search for a string
#      + search within a string
#      + replace one part of a string with another string

grepl() # "grep logical"
> regular_expression <- "a"
> string_to_search <- "Maryland"
> grepl(regular_expression,string_to_search)
[1] TRUE
grepl() #search "regular_expression" in "string" -> if "string" contains "regex" -> TRUE

#metacharacter
> grepl("a.b", c("aaa", "aab", "abb", "acadb"))  # "." any character
[1] FALSE  TRUE  TRUE  TRUE
> grepl("a+","Maryland")                         # "+" one or more of the preceding expression is present
[1] TRUE
> grepl("x*","Maryland")                         # "*" zero or more of the preceding expression is present
[1] TRUE
> grepl("s{2}","Mississippi")                    # {} exact numbers of expressions -> "a{5}" specifies "a" exactly five times 
[1] TRUE                                         #                                    "a{2,5}__________"a" between 2 and 5 times
                                                 #                                    "a{2,} __________"a" at least 2 times

# "()" create a capturing group
# capturing group -> use quantifiers on other regular expressions
> grepl("(iss){2}", "Mississippi")  #"iss" exists twice adjacently in the string
[1] TRUE

grepl("(i.{2}){3}", "Mississippi")  #"i" followed by 2 of any character, with that pattern repeated three times adjacently
[1] TRUE

# words ("\\w")       -> letter, digit, or a underscore
# not words ("\\W")
# digits ("\\d")      -> 0 - 9
# not digits ("\\D") 
# whitespace ("\\s")  -> line breaks, tabs, or spaces
# not whitespace ("\\S")

> grepl("\\d", "0123456789") # TRUE if string "0123456789" contains a digit
[1] TRUE

# [] specify specific character sets
# "[aeiou]" character set of just the vowels
# "[^aeiou]" matches all characters except the lowercase vowels
# [ - ] ranges of characters
# "[a-m]" matches all of the lowercase characters between a and m
# "[5-8]" matches any digit between 5 and 8

>grepl("[a-mA-M]", "ABC")      # "a-m" or "A-M"
[1] TRUE

# put 2 backslashes "\\" before a punctuation mark -> looking for symbol, not metacharacter meaning
> grepl("\\.","http://www.jhsph.edu/")
[1] TRUE

# "^" begining of string
# "$" ending of string
> grepl("^a", c("bab", "aab"))
[1] FALSE  TRUE
> grepl("b$", c("bab", "aab"))
[1] TRUE TRUE

# "|" metacharacter matches either the regex on the left or the regex on the right side "|"
> grepl("a|b", c("abc", "bcd", "cde"))
[1]  TRUE  TRUE 

# Find state names that both begin and end with a vowel
# Requirement: regex -> match beginning of string, then one instance of a capalized vowel, then any characters until one instance of a lowercase vowel followed by the end of the string

> start_end_vowel <-"^[AEIOU]{1}.+[aeiou]{1}$"
> vowel_state_lgl <- grepl(start_end_vowel, state.name)
> state.name[vowel_state_lgl]
[1] "Alabama"  "Alaska"   "Arizona"  "Idaho"    "Indiana"  "Iowa"     "Ohio"     "Oklahoma"


### Lesson 15: The Stringr Package

> grepl("[Ii]", c("Hawaii", "Illinois", "Kentucky"))
[1]  TRUE  TRUE FALSE
> grep("[Ii]", c("Hawaii", "Illinois", "Kentucky"))
[1] 1 2

sub("regex","replacement","vetor of string")      # replace the FIRST instance of the regex found in each string
gsub("regex","replacement","vetor of string")     # ________ EVERY _____________________________________________

> sub("[Ii]", "1",c("Hawaii", "Illinois", "Kentucky"))
[1] "Hawa1i"   "1llinois" "Kentucky"
> gsub("[Ii]", "1",c("Hawaii", "Illinois", "Kentucky"))
[1] "Hawa11"   "1ll1no1s" "Kentucky"

# Store the names of all of the US states that contain two adjacent "ss"
> two_s <- state.name[grep("ss", state.name)]
> two_s
[1] "Massachusetts" "Mississippi"   "Missouri"      "Tennessee"    
#split each string where the "ss" are located
> strsplit(two_s, "ss")
[[1]]
[1] "Ma"        "achusetts"
[[2]]
[1] "Mi"   "i"    "ippi"
[[3]]
[1] "Mi"   "ouri"
[[4]]
[1] "Tenne" "ee" 

# strings package
str_extract("string","regex")    # returns the sub-string of a string that matches the providied regex
> str_extract("Camaro Z28", "[0-9]+")
[1] "28"

str_order()    #returns a numeric vector that corresponds to the alphabetical order of the strings in the provided vector
> str_order(c("p", "e", "n", "g"))
[1] 2 4 3 1

str_pad()      #
> str_pad("Thai", width = 8, side = "left", pad = "-")
[1] "----Thai"

str_to_title() # 
> str_to_title(c("CAPS", "low", "Title"))
[1] "Caps"  "Low"   "Title"

str_trim()     #deletes whitespace from both sides of a string
> str_trim(" trim me ")
[1] "trim me"

word() #index each word in a string as if it were a vector
> word("See Spot run.", 2)
[1] "Spot"








