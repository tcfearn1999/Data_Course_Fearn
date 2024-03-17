# March 5####
library(tidyverse)
library(easystats)
library(palmerpenguins)

#optim() in reading uses gradient descent with least squared values
#does body_mass_g vary significantly between penguin species?

data <- palmerpenguins::penguins

names(data)

mod <- glm(data = data,
           formula = body_mass_g ~ species)

#in this can chande intercept by making species into Factors
#all species are being compared to intercept which is Adelie because it's
#alphabetically first
#outcome variable is numeric continuous 
summary(mod)

#looking at outcome models that classify with True or False
names(data)
#predict if penguin is gentoo based on bill length, depth, flipper length and body mass
"bill_length_mm"    "bill_depth_mm"     "flipper_length_mm" "body_mass_g" 

#change family distribution to binomial
mod2 <-
penguins %>% 
  mutate(gentoo = case_when(species == "Gentoo"~TRUE,
                            TRUE ~FALSE)) %>% 
  glm(data = ., 
      formula = gentoo ~ bill_length_mm + bill_depth_mm + flipper_length_mm + body_mass_g, #dot means what you piped, need to do this for older modeling functions
      family = "binomial") #logistic regressoin, classifier between true false

check_model(mod2)
summary(mod2)

#logistic regression, family binomial and output in true or false####
#need to put type = respnse in predict, this outputs precentages

penguins$pred <- predict(mod2, penguins, type = "response" )

#this shows that the model was able to succesfully predict gentoos
penguins %>% 
  ggplot(aes(x= body_mass_g, y = pred, color = species)) +
  geom_point()
#the y-axis is chance of being a gentoo

preds <-
penguins %>% 
  mutate(outcome = case_when(pred < 0.01 ~ 'Not gentoo',
                             pred > 0.75 ~ 'gentoo')) %>% 
  select(species, outcome) %>% 
  mutate(correct = case_when(species == "Gentoo" & outcome == 'gentoo' ~ TRUE,
                             species != "Gentoo" & outcome == 'Not gentoo' ~TRUE,
                             TRUE ~ FALSE))

preds %>% 
  pluck("correct") %>% 
  sum() / nrow(preds)

#machine learninig is just a bunch of logistic regressions, a bunch of true or false
#softmax classier just has true false categories for each option 

dat <- read_csv('./Data/GradSchool_Admissions.csv')

#outcome is whether you got admitted or not (response variable)
#rank is rank of school you came from 
mod3 <- 
  glm(data = dat, 
      formula = as.logical(admit)~ (gre + gpa) *rank,
      family = 'binomial')

dat$pred <- predict(mod3, dat, type = 'response')

#rank 1 is harvard and rank 4 is very low 
#with continuos points you can make cool plots
dat %>%
  ggplot(aes(x=gre, y= pred, color = factor(rank)))+
  geom_point(alpha = 0.25) +
  geom_smooth() 


# can do same with categorical data with boxplots with jitters 
dat %>%
  ggplot(aes(x=factor(rank), y= pred, color = factor(rank)))+
  geom_jitter(alpha = 0.25) +
  geom_boxplot()

#anvoa, shows that atleast one of them is different (useless)
aov(data = penguins,
    formula = body_mass_g ~ species)

#lmer 
#decision trees, prediction supervised
#depends on how you split things, need many decision trees to create accurate predictions
#the many trees are a forest 


#March 7####



#show and tell for pdfs
#installed.packages("pdftools")
#can use to extract info, add signature and combine pdfs 
#play around with as it can help avoid using adobe 


library(tidyverse)
library(easystats)
library(broom)
library(caret)
library(modelr)
library(kableExtra)

mod1 <- mpg %>% 
  glm(data=.,
      formula = cty ~ displ + drv ) #fit model to data, displ and drv have no interaction 
broom::tidy(mod1) #turns model output into a data frame

summary(mod1)

#creates interactive reports
broom::tidy(mod1) %>% 
  kableExtra::kable() %>% 
  kableExtra::kable_classic(lightable_options = 'hover')

#perfect model is a line 
add_predictions(mpg, mod1) %>% 
  ggplot(aes(x=pred, y=cty))+
  geom_point()

#plot residuals to see how far off we are
add_residuals(mpg, mod1) %>% 
  ggplot(aes(x=resid, y=cty))+
  geom_point()
#the above model is off for trucks because there are less in our dataset

#cross-validation: test your model on new data (that you haven't seen and has actual answers)
#train it on 80% of mpg dataset 
#test on 205 of mpg dataset

#randomly sample rows 
mpg$drv %>% table

#need to sample from all groups randomly
#takes into account the stratification of your data

#the p parametrer is how much of the data you are training on. .8 is typicall but depends on data
id <- caret::createDataPartition(mpg$cty, p = .8, list = FALSE)
#the above outputs rows from dataset

train <- mpg[id,]
test <- mpg[-id,]

#train model on training set
mod2 <- glm(data= train,
            formula = mod1$formula)
add_predictions(test, mod2) %>% 
  mutate(error = abs(pred - cty)) %>% 
  pluck('error') %>% 
  summary()
#the above show that our model was off on average by 1.4 mpg
#the above is the real test 

#model that trained on a subset didn't do as well 
#because its already seen the data
add_predictions(test, mod1) %>% 
  mutate(error = abs(pred - cty)) %>% 
  pluck('error') %>% 
  summary()

#train it on as much data as possible 
#would use model 1 to predict with future validation 
#cross-validation doesn't change your model at all.







































