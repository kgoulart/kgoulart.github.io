rm(list=ls())

data("USArrests") #imports data from R's list of datasets

# explore dataset
head(USArrests) 
#   pulls the top 6 observations

tail(USArrests)

summary(USArrests)

summary(USArrests$UrbanPop)
#   to look at one variable in the USArrests
#   you have to call the dataset every time

plot(USArrests$UrbanPop)
#   Doesn't make sense because we haven't told it how to plot it.

hist(USArrests$UrbanPop)

boxplot(USArrests$Murder, main="Title")
#   main allows you to name the title

boxplot(USArrests$Murder, 
        main="Title",
        ylab="number of murders",
        xlab="don't need it")

rm(list=ls())
###################################

#tidyverse
install.packages("tidyverse")
library("tidyverse")
install.packages(dplyr)
library(dplyr)
# tidyverse is a collection of functions 

setwd("/Users/kimberlygoulart/UPF PhD/Stats:Research Resources/R")
getwd()

pob <- read.csv("Datasets-20200627_Toni/barris_poblacio.csv")
#   when you hit / and then tab, it will bring up the directory






























