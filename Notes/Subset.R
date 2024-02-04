# January 25 ####
install.packages("palmerpenguins")
library(tidyverse)
library(palmerpenguins)

#subset for observation that bill_length_mm > 40
#then find mean of penguins that are the above, female and their 
#mean body length
#need to use quotes with pluck 
big_bill <- penguins %>% 
  filter(bill_length_mm > 40 & sex == "female") %>% 
  pluck("body_mass_g") %>% 
  mean

#you can get mean in the above way or like bellow 
big_bill$body_mass_g %>% mean
#ctrl shift M for the pipe

#summarise by species and create new data frame with summarize()
#N is the number of penguins that meet the requirements specified 
#print this to a CSV table
penguins %>% 
  filter(bill_length_mm > 40 & sex == "female") %>% 
  group_by(species,island) %>% 
  summarize( mean_body_mass = mean(body_mass_g), 
             min_body_mass = min(body_mass_g),
             max_body_mass = max(body_mass_g),
             sd_body_mass = sd(body_mass_g),
             N = n()) %>% 
  arrange(desc(mean_body_mass)) %>%     #displays them in descending numerical order
  write_csv("./Data/penguin_summary.csv")

#for the above functions you can only use desc() in another function
#n() doesn't need any arguments but you can put some. 

#find the fattie penguins (body_mass_g > 5000)
#count how many are male and how many are female
#return the max body mass for mail and females
#bonus: add new column that says wehther they're a fattie 

penguins %>% 
  filter(body_mass_g > 5000) %>% 
  group_by(sex) %>% 
  summarize( N=n(),
            max_body = max(body_mass_g))

#filter will help filter rows, select is for columns
#mutate will change columns
#case_when only works inside another function 
x <-
penguins %>% 
  mutate(fatstat = case_when(body_mass_g > 5000 ~ "FATTIE" , 
                             body_mass_g <= 5000 ~ "Skinny"))

  


#exposure to plotting right now and will continue next week
x %>% 
  ggplot(mapping = aes(x = body_mass_g, 
                       y = bill_length_mm,
                       color = fatstat,
                       shape = fatstat)) + 
  geom_point()+
  geom_smooth() +
  scale_color_manual(values = c('salmon', "blue")) + 
  #scale_color_viridis_d(option = "plasma", end = .8)
  theme_dark() +
  theme(axis.text = element_text(angle = 120, face="italic"))

library(tidyverse)

#converting expressions into pipe format
 iris$Species %>%
   stringr::str_to_title() %>% 
   unique()
 
 iris$Sepal.Length %>% 
   round(,0) %>% 
   max()
 
 c(100,0,5) %>% 
   rnorm() %>% 
   abs() %>% 
   mean()
 
seq(1,100,0.01) %>% 
  round(,1) %>%
  median()
  






