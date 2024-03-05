#1. Read in the unicef data (10 pts) #### 
library(tidyverse)
library(stringr)
library(easystats)


file <- "unicef-u5mr.csv"

df <- read_csv(file)

#2. Get it into tidy format (10 pts) #### 

#combine the years into two rows, one for year and other for U5MR
#also take out N/a's and replace with zero
df2 <-
df%>% 
  pivot_longer(-c(CountryName, Continent, Region),
               names_to = "year", 
               values_to = "u5mr")

#take out U5MR in year column
df2$year <- str_remove(df2$year, "U5MR.")


#3. Plot each country’s U5MR over time (20 points)#### 

plot1 <- 
  df2 %>% 
  ggplot(aes(x = year, y = u5mr, group = CountryName)) +
  geom_line(na.rm = TRUE) +
  facet_wrap(~Continent) +
  scale_x_discrete(breaks = c(1960, 1980, 2000), labels = c(1960, 1980, 2000))


#4. Save this plot as LASTNAME_Plot_1.png (5 pts) 
ggsave("./Fearn_plot_1.png")

#5. Create another plot that shows the mean U5MR for all the countries within a given continent at each year (20 pts)

mean_u5mr <- df2 %>%
  group_by(year, Continent) %>%
  summarise(mean_u5mr = mean(u5mr, na.rm = TRUE))

plot2 <-
mean_u5mr %>% 
  ggplot(aes(x = year, y = mean_u5mr, group = Continent, color = Continent)) +
  geom_path() +
  scale_x_discrete(breaks = c(1960, 1980, 2000), labels = c(1960, 1980, 2000))

#6. Save that plot as LASTNAME_Plot_2.png (5 pts)
ggsave("./Fearn_plot_2.png")

# 7. Create three models of U5MR (20 pts)

#mod1 should account for only Year
mod1 <- glm(data = df2, formula = u5mr ~ year)

#mod2 should account for Year and Continent
mod2 <- glm(data = df2, formula = u5mr ~ year + Continent)

#mod3 should account for Year, Continent, and their interaction term
mod3 <- glm(data = df2, formula = u5mr ~ year * Continent)


#8. Compare the three models with respect to their performance
#Your code should do the comparing
#Include a comment line explaining which of these three models you think is best
compare_performance(mod1, mod2, mod3) %>% plot()

#BEST MODEL: mod3 is the best overall but is lacking in terms of BIC. However, it shows the 
#the lowest error and highest correlation value R^2.

#9. Plot the 3 models’ predictions like so: (10 pts)
df2$pred <- predict(mod1, df2)
df2$pred2 <- predict(mod2, df2)
df2$pred3 <- predict(mod3, df2)


#plotting predictions
df2 %>% 
  pivot_longer(starts_with('pred')) %>% 
  ggplot(aes(x= year, y = value, color = Continent, group = Continent))+
  geom_line(na.rm = TRUE)+
  facet_wrap(~name) +
  scale_x_discrete(breaks = c(1960, 1980, 2000), labels = c(1960, 1980, 2000))+
  labs(title = "Model Predictions", y = "Predicted U5MR")

#10. BONUS - Using your preferred model, predict what the U5MR would be for Ecuador in the year 2020. 
#The real value for Ecuador for 2020 was 13 under-5 deaths per 1000 live births. 
#How far off was your model prediction???

#need to convert year away from factor, retrain model three and then use that 
#to predict

real <- 1000/13

ecuador <- df2 %>%
  filter(CountryName == "Ecuador") 

ecuador <- ecuador[1:31,1:3] %>% 
  mutate(year = as.character(1990:2020)) %>% 
  levels(droplevels(year)) %>% 
  data.frame()

predict(mod3, newdata = ecuador)





