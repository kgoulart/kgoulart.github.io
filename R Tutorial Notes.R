# Introduction to R - Toni Rodon

# S language allows you to create packages and functions.
# CRAN package respository
# 2 conceptual parts - 1. 'base' R system that you download from CRAN; 2. everything else; download a library.
# Quantitative Social Science - An Introduction
# Stack overflow - reddit for softwares

# Things you can do - 
# can automate weekly reports (like macros in excel)
# can use it for websites
# can extract info from instagram and facebook - and telegram/whatsapp
# can do 3-D graphics
# can extract text from a pdf (or an old pdf) which is an image.

# R is an object-based language - everything has a name; everything is a object; and every object has a class.
# Variable names cannot have blank spaces; case-sensitive
# An object can only be of 1 class (not hybrid numbers) - observations have to be consistent.
# it is possible to work with multiple objects at the same time
# you can call objects from different datasets

###########
# OBJECTS #
###########
# character string - words
# numbers
# vectors - list of different characters
# matrices - collection of vectors
# data frame - dataset
# list - collection of different things
# NA - missing variables = dot in stata
# undefined - (is.null) - nothing there
# TRUE: logical TRUE(isTRUE) - logical values - logical vector / FALSE 
#   type of variable that are logical
# Tip - create dataframes whenever you can
# have to install the package everytime R is updated.

# install packages
# Github - dropbox for geeks
# CRAN - official packages by R
# Twitter - to find new packages - #rstats; #tidytuesday
# rbloggers - newsletter

##############
# 10:40 part #
##############

# Save script - no spaces; use underscores or dashes
# R is a calculator
# Not good practice to write in the console
5+2

# First object
# character
a <-"toni"
class(a)

# Integer
b <- c(1:10)
class(b)
# class tells us what kind of object/variable it is - numeric

# Numeric value with decimals
c<-c(1,2.4,5.6)
c 
class(c)
# c - allows us to inspect what I just created

# factor / categorical / binary
sex <-factor(c("male","female", "female", "male"))
sex
# levels are categories
class(sex)

levels(sex)
#   levels tells us the categories

nlevels(sex)
#   nlevels = number of categories

# Logicals
x <- 1
x

y<-2
y

z <- x>y
z
# we get FALSE - bc x isn't bigger than y
# come in handy when you want to see if a dataset has more than 10 missing values; give me a TRUE.

# Date/time
today <- Sys.Date()
today
d <- as.Date("23/04/1985")
class(d)

d <- as.Date("23/04/1985", format="%d-%m-%Y")
# returns an NA because of dashes rather than slashes
d <- as.Date("23/04/1985", format="%d/%m/%Y")

# Working Directory
getwd()

# more help
help("lm")

help.search("regression")
?lm
??lm
??regression

# Vector
a <-5
# read it as assign a 5 to a
# read as left to right

d <-"a"
# assign a to d
d <- a
#   doing this will overwrite what i already did.


# can create a vector that is a long piece of text.
# every time there is a space there is an \n\

longanduselesstext <- "Officials nationwide were rethinking their efforts to slow the virus, which the nation’s top infectious disease expert said were not working."
longanduselesstext

ls()

rm(a)
# removes a

a <- 5
b <- 4

a+b
c <- a+b
#   A way to create variable - e.g. sum the incomes of persons in hh
c

d <- "z"
a+d
#   You'll get an error

z <- 3:20
z

rm(list=ls())

###########
# VECTORS #
###########
x <- rep(5, time=25)
# repeat the value 5, 25 times
y <- rep("b", time=25)
x <- rep(1:5, time=4)
rep(1:5, time=4)
# without creating an object - just to see what the result it

y <- rep(letters, 4)
y <- rep(LETTERS, 4)

y <- rep(LETTERS [1:8], 4)
#  repeat the alphabet 4 times but only the first 8 letters in caps

x <- rep(1:5, each=6, times=5)
# create a sequence of 1 through 5; repeat each number 6 times; and repeat this command 5 time
x

seq(from=1, to=50, by=2)
# creating a sequence from 1 to 50 but only every 2 values - e.g. 1, 3, 5, 7...50

length(x)
# tells me how many observations variable x has

x[6]
# tells me what the 6th observation is - what the value is.

x[c(6,8,40)]
# tells me what the values of the 6th, 8th, and 40th observation

x[-2]
# show everything except the 2nd observation

a <- 1:8
#   variable from 1:8
d <- matrix(a, ncol=2, byrow=T)
#    put into a matrix using 2 with 2 columns and sort by row
d

# comma before row - e.g. [1,] = 1st row
# comma after column - [,1] = 1st column

d[,2]
#extract everything except the first column
d[2,]

rm(list=ls())
# empty's global environment

g <- data.frame(Name=c("Marina", "Queralt", "Andreu", "Harold"),
                ideol=c(2,9,5,6),
                goals=c(10,9.5,1,0))
# create a dataset with 1st variable with names and it has 4 values that are all text. Create another variable that is ideology; another variable that is goals.

g$goals
# call the variable

ess$gender
# tells R to use ess dataset and call the variable gender.

############
# Exercise #
############

#Create an object named a that represents a vector of 4 elements which includes the numbers 5 to 8 (both included).
a <- 5:8

#List the second element of the object
a
a[2]

#List the fourth element of the object
a[4]

#Multiply the second and the fourth element of the object
a2 <- a[2]*a[4]
a2

#Create a new object with the numbers 3 and 4. Call the object b. After that, use b to extract the third and fourth element of the object a.
b <- c(3,4)
a[b]

#Extract all elements in a except for the second one. 
a[-2]

#Extract all elements in a except for the third and the fourth.
a[c(3,4)]



#Create a matrix with 3 rows and 3 columns. Do it in such a way that the first row includes numbers from 1 to 3, second row from 4 to 6
#and third row from 7 to 9.
c1 <- data.frame(g=c(1:3),
                h=c(4:6),
                i=c(7:9))

c <- matrix(1:9,ncol=3,byrow = T)
#   T stands for TRUE - sort by row T' sorts by column by default

#Extract the value in the second row, second column
c[2,2]

#Extract AND LIST the value in the second row
c[2,]

#Extract and list all the values in the third column
c[,3]

#Convert the object created before (matrix) into a dataframe
class(c)
d <- data.frame(c)
view(d)

#Extract the second observation in the second variable
d[2,2]
d$X2[2]

#Extract all values from the second row/observation
d[2,]

#Extract all values in the third variable
d$X3

#Create two ojects. One with 4 numbers and the other one with two 'characters'
e <- c(3,4,5,6)
f <- c("a","b")

#Use the function list() to create an object that consists of a list of the two previous objects
g <- list(e,f)
g
class(g)
# list is an object that creates different datasets

#Use the function names() to change the names of the sub-objects you have just created
names(g) <- c("numbers", "letters")
g

#Create an object that contains a repetition of even numbers from 1 to 50
rep(seq(2,50,2),times=10)































