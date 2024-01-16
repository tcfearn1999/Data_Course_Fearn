#Assignment 2 , Tayler Fearn, BIOL3100

#like pwd
getwd()

#lists the files in the current wd
list.files(path = "Assignments/", recursive = TRUE)

#set working directoyr to ~/Data
setwd("~/Data_Course_Fearn/Data/")

#create for loop to go through all files and gather CSV files

data_csv <-list.files( pattern = ".csv", recursive = TRUE)
data_csv[158]

dat <- read.csv(data_csv[158])

#highlight and click control enter to run the code highlighted code 

readLines("Data/wide_rent_income.csv")

read.csv("Data/wide_rent_income.csv")
      
#assignment number 2

# 4 Write a command that lists all of the .csv files found in the Data/ directory 
#and stores that list in an object called “csv_files”
data_csv <- list.files(pattern = ".csv", recursive = TRUE, path = "Data")

# 5 Find how many files match that description using the length() function
 y <- length(data_csv)

# 6 Open the wingspan_vs_mass.csv file and store the contents as an 
#R object named “df” using the read.csv() function
#Use the list.files() because it allows for more robust code
df <- read.csv(list.files(pattern = "wingspan_vs_mass.csv", recursive = TRUE))

# 7 Inspect the first 5 lines of this data set using the head() function
top_df <- head(df, n = 5)

# 8 Find any files (recursively) in the Data/ directory that begin with the letter “b” (lowercase)
list.files(pattern = "^b", recursive = TRUE, path = "Data")

# 9 Write a command that displays the first line 
#of each of those “b” files (this is tricky… use a for-loop)

#create variable with the files and the full file path
b_files <- list.files(pattern = "^b", recursive = TRUE, path = "Data", full.names = TRUE)

#for loop will iterate through the files and read the first line
for (file in b_files){
  print(readLines(file, n=1))
}

# 10 Do the same thing for all files that end in “.csv”

#save the list of files with full_name so that the for loop can find them when iterating through
data_csv <- list.files(pattern = ".csv", recursive = TRUE, path = "Data", full.names = TRUE)

for (file in data_csv){
  print(readLines(file, n=1))
}

#assignment 2 ends


for(file in list.files( recursive = TRUE, pattern = ".csv")){
  print(file)      #need to change to print the name of the file, not the file
    
}
