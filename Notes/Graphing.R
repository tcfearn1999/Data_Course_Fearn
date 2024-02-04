#January 30th####
#need to clone and BIOL3100_exams into out computer (on Zahn's github) to get exams
#put exams in own folder in data course
#open up exam1 Rproject 
#put the task with comment lines in your code

#ctrl shift m for pipe
#ctrl shift c for commenting something

#assignment 4 is submitting information for the final project we plan on doing

library(tidyverse)
library(palmerpenguins)

big_bill <- penguins %>% 
  filter(bill_length_mm > 40 & sex == "female") %>% 
  pluck("body_mass_g") %>% 
  mean

#you can get mean in the above way or like bellow 
big_bill %>% mean
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

names(penguins)
#the below bar graph shows the sum of all the penguins 
ggplot(penguins, mapping = aes(x = flipper_length_mm,
                               y = body_mass_g, 
                               fill = species))+
  geom_col()

ggplot(penguins, mapping = aes(x = flipper_length_mm,
                               y = body_mass_g, 
                               fill = species))+
  geom_col(position = "dodge")

#global aesthetics ggplot but every geom can have own eastheitics 
# the aesthetics will equal 
ggplot(penguins, mapping = aes(x = flipper_length_mm,
                               y = body_mass_g, 
                               color = species))+
  geom_path(aes(group = species))+
  stat_ellipse() +
  geom_point(color = 'white')  #put something outside of aes and it is just general 
#put it in aestheic and you can make it work according to different columns

ggplot(penguins, mapping = aes(x = flipper_length_mm,
                               y = body_mass_g, 
                               color = species))+
  geom_path(aes(group = species))+
  stat_ellipse() +
  geom_polygon() +
  geom_point(aes(color = sex))+
  geom_hex()+
  geom_bin_2d() +
  geom_boxplot()


ggplot(penguins, mapping = aes(x = flipper_length_mm,
                               y = body_mass_g, 
                               color = species))+
  geom_path(aes(group = species))+
  stat_ellipse() +
  geom_polygon() +
  geom_point(aes(color = sex))+
  geom_hex()+
  geom_bin_2d() +
  geom_quantile()+
  geom_hline(yintercept = 4500, linewidth = 25, color = "magenta",
             linetype = '1121', alpha = 0.50)



ggplot(penguins, mapping = aes(x = flipper_length_mm,
                               y = body_mass_g, 
                               color = species,
                               alpha = bill_depth_mm))+
  geom_path(aes(group = species))+
  stat_ellipse() +
  geom_polygon() +
  geom_point(aes(color = sex))+
  geom_hex()+
  geom_bin_2d() +
  geom_quantile()+
  geom_hline(yintercept = 4500, linewidth = 25, color = "magenta",
             linetype = '1121', alpha = 0.50)+
  geom_point(color= "yellow", aes(alpha = bill_depth_mm))+
  theme_void()+
  theme(axis.title = element_text(face = 'italic', size = 12, angle=30))


ggplot(penguins, mapping = aes(x = flipper_length_mm,
                               y = body_mass_g, 
                               color = species,
                               alpha = bill_depth_mm))+
  geom_point(color= "blue", aes(alpha = bill_depth_mm))+
  theme(axis.title = element_text(face = 'italic', size = 12, angle=30))


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
