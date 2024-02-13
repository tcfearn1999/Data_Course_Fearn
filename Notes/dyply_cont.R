#Febuary 8 2023####

library(tidyverse)

#load data set

df <- read_csv("./Data/wide_income_rent.csv")

#plot rent prices for each state 
#state on x-axis, rent on y-axis, bar chart 
#hard to do becuase of the df structure
#the df needs to be transposed s

names(df)
df2 <- data.frame(t(df))

df2 <- df2[-1,]

df2$State <- row.names(df2)
names(df2) <- c("income", "rent", "state")

#easier way to do the saem thing but easier
df %>% 
  pivot_longer(-variable, names_to = "state", values_to = "amount") %>% 
  pivot_wider(names_from = variable, 
              values_from = amount) %>% 
  ggplot(aes(x = state, y = rent))+
  geom_col()+
  theme(axis.text.x = element_text(angle = 90, hjust = 1 , vjust = .5, size = 10))

#if one variable is spread across multiple colums  - pivot longer
#if multiople variables are in a single column - pivot wider
#every row is one observation in tidy data

#practice pivot longer and pivot wider
table1 
table2

table2 %>% 
  pivot_wider(names_from = type,
              values_from = count)
table3 %>% 
  separate(rate, into = c("cases", "population"))

#pratice joining tables
table4a_fixed <- table4a %>% 
  pivot_longer(-country, names_to = "year", values_to = "cases")

table4b_fixed <- table4b %>% 
  pivot_longer(-country, names_to = "year", values_to = "population")

full_join(table4a_fixed, table4b_fixed)
  


table5 %>% 
  separate(rate, into = c("cases", "population"), convert = TRUE) %>% 
  mutate(year = paste0(century, year) %>% as.numeric()) %>% 
  select(-century) 

library(readxl)

#store things as month, day and year in seperate columns 
dat <- read_xlsx("./Data/messy_bp.xlsx", skip = 3)

#fix the above data over the weekend

bp <- dat %>%
  select(- starts_with("HR"))

bp %>% 
  pivot_longer(starts_with("BP"), names_to = "visit", values_to = "bp") %>% 
  mutate(visit = case_when(visit == "BP...8" ~1,
                           visit == "BP...10" ~2,
                           visit == "BP...12" ~3))

#need to seperate 

#ggmagnify 