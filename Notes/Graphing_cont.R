
library(tidyverse)
library(palmerpenguins)

names(penguins)
#make an intresting plot of the penguins 
ggplot(penguins, mapping = aes(x = bill_depth_mm,
                               y= bill_length_mm, 
                               color = species))+
  geom_point()+
  geom_smooth()+
  theme_minimal()
  

#rules for a good plot####
##don't hide your data, like with boxplots####
##have a goal####
penguins %>% 
  ggplot(aes(x=species,
             y=body_mass_g))+
  geom_boxplot()+
  geom_jitter(height = 0, width = 0.1, alpha= 0.2)

#this is a distributiuon plot, geom density only needs an x or a y
penguins %>% 
  ggplot(aes(x = body_mass_g,
             fill = species))+
  geom_density(alpha = .4)

penguins %>% 
  ggplot(aes(x = body_mass_g,
             fill = species))+
  geom_histogram(alpha = .4)

df <- read_delim("./Data/DatasaurusDozen.tsv")

df %>% 
  group_by(dataset) %>% 
  summarise(meanx = mean(x),
            sdx = sd(x),
            minx = min(x),
            medianx = median(x))
##plot data before you look at stats####
df %>% ggplot(aes(x=x , y=y))+
  geom_point()+
  facet_wrap(~dataset)

install.packages("GGally")
library(GGally)

#this is good if you don't have 3000 columns
ggpairs(penguins)

penguins
## make it easy for people to see the story in yor figure####
penguins %>% 
  filter(sex != "NA") %>% 
  ggplot(aes(x = bill_depth_mm,
             y = body_mass_g,
             color = sex))+
  geom_point()+
  facet_wrap(~species)+
  theme_minimal()
  
penguins %>% 
  filter(sex != "NA") %>% 
  ggplot(aes(x = bill_depth_mm,
             y = body_mass_g)+
  geom_point(eas(color=sex))+
  facet_wrap(~island)+
  geom_area()
  
##axis titles matter####
  
#T-test looks at difference in means and is useless 
#show and tell
#leaflet 
install.packages("leaflet")
library(leaflet)
#creates intercative geographical plots
#could look at acces to water througout the US


#pre-explore gap minder
install.packages("gapminder")

#Febuary 05####
install.packages("ggimage")
install.packages("gganimate")
install.packages("patchwork")

library(tidyverse)
library(ggimage)
library(gganimate)
library(patchwork)
library(gapminder)

#need to watch gapmindr video in teams
#for ugly plot looking for a plot that is ugly, doesn't convey any information 
#or conveys information incorrectly (missing axis), things shown on the same plot with
#different scales 
#can change to coord polar
#look at awesome ggplot 2 links to incorporate into 
#GeomRug
#XKCD - makes stick figure comics and graphs

#more plotting today
names(gapminder)

p <- gapminder %>% 
  ggplot(aes(x = year, y =gdpPercap , color = continent))+
  geom_point()

p.dark <-
  p + 
  theme_dark()

p2 <- p +
  facet_wrap(~continent)

p + p.dark

(p + p.dark)/p +plot_annotation("Main Title") +
  patchwork::plot_layout(guides = "collect")

p + p2 + plot_annotation(title = "Compare with and without facets")

df <- gapminder

my_countries <- c("Venezula", "Rwanda", "Nepal", "Irag", "Afganistan", "United States")


#parctice mutate with case when 
df <- df %>% 
  mutate(mycountries = case_when(country %in% my_countries ~ country))

view(df)

p3 <- 
  ggplot(df, 
         mapping =  aes(x = gdpPercap , y = lifeExp, color = continent))+
  geom_point(aes(size = pop))+
  geom_text(aes(label = mycountries))

p3 +
  transition_time(time = year)+
  labs(title = "year: {frame_time}")

#save an animation
anim_save("./Notes/gapminder_animation.gif")

#save a ggplot, dpi 300 is the minimum for printing
ggsave("./Notes/plot_example.png", plot = p3, width = 6, height = 6 ,dpi = 50)






