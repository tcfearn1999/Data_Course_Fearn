#January 18th 

#R is has built in for loops

x <- c(1, 2, 3, 4, 5, 6)

for(i in x){
  print(i+1)
}

#the above for loop can be done with the below code
x+1

#this can be done also like the following
1:5
x^3
seq(1, 1000, by=7)

#this is possible because of vectors in R
#vectors have mangitude, direction and dimensionality

#x is a numeric vector
class(x)

#x is a vector of length 1
length(x)

#the lenght of the return of length x is 1
length(length(x))

#the class of class x is numeric, which is a character
class(class(x))

#different data tyoes in R that are treated differently 
#concatenation works different in R than in Python 
#the following is concatenation that takes things and puts it 
#in a vector of lenght 2
c("2", "a")

#everything in vector has to be the same data type
c(1, "a")
#for the above the 1 is turned into a charater, the default of 
#concatenante is turning everything into character 

#vector has a class (numeric, character)
#it has one dimension and must be the smae class
#length of vector can be 0
#ex
length(c())

#adds the ith element to the ith element of the other element 
#matric math 
1:5 + 1:5

a <- 1:10
b <- 2:11

#assigns c to built in class of letters and the first 10 of the letters
c <- letters[1:10] 

#this is how you look for elements 1,3,5 in the letters vector, you need to feed
#it a single element of what you want and so you concatenate 1,3,5 into a numeric vector
letters[c(1,3,5)]

#can stick a,b ,c together and man
cbind(a,b,c)

#puts them all together while maintaining data type, only waorks with everything
#has the same number of rows
#a data frame is a list of vectors
z <- data.frame(a,b,c,d)
length(z)
class(z)
#dimensions is listed columns and then rows 
dim(z)

#to rep soemthing use the following function and will add that into df z
 d <- rep(TRUE, 10)

 #logical vector class
 1 > 0 #is 1 greater then 0
 0 >= 0 #is 1 greater then or equal to 0
 1 == 1 #is one equal to one
 1 != 1 #is one not equal to one 
#the follow will compare the ith index to the ith index of another vector  
 5 > a
 
 
 #subset data with true false, 
 #extracts all a's that are greater than 5
 a [5 < a]
 
#goes through and prints all rows where a is greater than 5
#a data fram has two dimensions row, column
z[5 > a,]
#pulls on the element in the 1st row, thrid column
z[1,3]
#pulls out the row where c is equal to b
z[c == "b", ]

#built in dataframe iris
iris

#both of the following will give you the number of rows that has 
#a seoal length greater than 5
nrow(iris[iris$Sepal.Length > 5 , ])
dim(iris[iris$Sepal.Length > 5 , ])[1]

#make a new data frame that is a subset of iris
big_iris <- iris[iris$Sepal.Length > 5,]

#create a new column in iris that is equal to sepal lenght times sepal width 
big_iris$Sepal.Area <- big_iris$Sepal.Length * big_iris$Sepal.Width

#give just setos species from iris dataset
big_setosa <- big_iris[big_iris$Species == "setosa",]

#mean sepal area from setosa
mean(big_setosa$Sepal.Area)

plot(big_setosa$Sepal.Length, big_setosa$Sepal.Width)
sd(big_setosa$Sepal.Area)
min(big_setosa$Sepal.Area)
max(big_setosa$Sepal.Area)
sum(big_setosa$Sepal.Area)
summary(big_setosa$Sepal.Area)

cumsum(big_setosa$Sepal.Area)
cumprod(big_setosa$Sepal.Area)

#Rpackadge of the week 
#qr code package alows you to make a QR code of any lenght of charcters 
install.packages("qrcode")
library(qrcode)

url <- "website"
qr <- qrcode::qr_code(url)
plot(qr)
#give all rows where species where virgenica or setosa
virg_set <- iris$Species == c('virginica','setosa')

#give all rows where the species is setosa and the area is greater than the mean
virg_set <- iris[iris$Species == c('virginica', 'setosa'),]

#spend a couple hours pratice dataframes and subsetting data and logical statements
#look at picture for ways to furhter manipulate data with tidyverse

# january 23####
#putting the four hastags ti the end of comment line ads a section to the outline

#1
#build dataframe from mtcars with only rows that have more than 4 cylinders(cyl)
four_cyl <- mtcars[mtcars$cyl > 4,]

#2
#pull out just the miles per gallon of those cars (Mpg)
#and find the min, max and mean
mpg_four_cyl <- four_cyl$mpg
mean(mpg_four_cyl)
max(mpg_four_cyl)
min(mpg_four_cyl)


##object types ####
###logical ####
c(TRUE, FALSE)

###numeric ####
1:10

###character ####
letters[3]

###integer ####
c(1L,2L,3L)

###data.frame ####
mtcars[rows,cols]   #has two dimensions
str(mtcars)      #shows structure of dataframe
names(mtcars)

as.character(mtcars$cyl)

#for loops assigns character version to every column over itself
for(col in names(mtcars)){
  mtcars[,col] <- as.character(mtcars[,col])
}
#check to see that the structure has chanegd
str(mtcars)


#this will reset the dataframe back to built-in data
data("mtcars")


### factor ####
#like character but stored in levels
as.factor(letters)

colors <- c("brown", "black", "blonde", "red", "black", "red")
factor <- c(as.factor(colors))   #redunces reduncancy in colors, purple can't be concatenated
as.numeric(c(as.factor(colors),"purple") )
color_factor <- as.factor(colors) 
levels(color_factor)


####type conversions ####
as.character(1:5)
as.numeric(letters)   #gives NA

#will convert 1 and 35 but leave NA for b
as.numeric(c("1", "b", "35"))

 x <- as.logical(c("true", "t", "f", "false", "T"))
sum(x)
sum(TRUE)
TRUE + TRUE
FALSE + 3
NA + 2    #gives NA

#add is na remover like so
sum(x,na.rm = TRUE)

##read csv file ####
path <- "./Data/cleaned_bird_data.csv"
df <- read.csv(path)

#for loop to convert all the columns to characters
for (col in names(df)){
  df[, col] <- as.character(df[, col])
}
str(df)

#write csv file to computer with new character data
write.csv(df, file = "./Data/cleaned_bird_data_chr.csv")

## family functions ####
#reset MTcars
data("mtcars")
str(mtcars)

#apply function applys a function to all rows or columns
# one is for rows and two is for columns
apply(mtcars, 2, as.character)

#converts positive number to true and 0's to false
apply(mtcars, 2, as.logical)

#converts to factor
apply(mtcars, 2, as.factor)

#this can be done with other data types
lapply(list, function)
vapply(list, function, FUN.VALUE = type, ...)
sapply(list, function)

##R packages ####

### tidyverse ####

#install tidyverse
install.packages("tidyverse")

#can install mulitple packages as such
#install.packages(c("vioplot", "MASS"))
#whichever function you load last will be the package that masks everyhting
#can undue this as such
stat::filter()
dplyr::filter()

#load module 
library(tidyverse)

# %>% pipe
#thing on the left side of the pipe becomes the first argument to the thing on the right
#comes with the tidyverse
#filter is used to subset data frames bu rows
mtcars %>%             #ctrl shift m
  filter(mpg > 19)     #retains all rows that match the filter

mtcars$mpg %>% 
  mean() %>% 
  abs()

mtcars %>% 
  filter(mpg > 19 & vs == 1)



