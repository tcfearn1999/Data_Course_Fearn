#Exam_01####
#Tayler Fearn
library(tidyverse)

# I. ####
#Read the cleaned_covid_data.csv file into an R data frame. (20 pts)
file <- "./cleaned_covid_data.csv"
df <- read.csv(file)

# II. ####
#Subset the data set to just show states that begin with “A” and save this as an object called A_states. (20 pts)
# Use the tidyverse suite of packages
# Selecting rows where the state starts with “A” is tricky (you can use the grepl() function or just a vector of those states if you prefer)
A_states <- df %>% 
  filter(grepl("^A", Province_State))

# III. ####
#Create a plot of that subset showing Deaths over time, with a separate facet for each state. (20 pts)
# Create a scatterplot
# Add loess curves WITHOUT standard error shading
# Keep scales “free” in each facet

#Note: for this I was unsure if you wanted this for A_States or all states so I did both. 
#Graph of all states
df %>% 
  ggplot(aes(x = as.Date(Last_Update), y = Deaths), color = Last_Update) +
  geom_point(alpha = 0.25) +                                         #I made the points more transparent so they were distinct
  geom_smooth(se = FALSE, method = "loess", color = "blue") +        #I made the line blue so it was more visible
  facet_wrap(~ Province_State, scales = "free") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+ #I added this line so that the date time would be more readable
  xlab("Date")
 
#Graph of Just A-States 
A_states %>% 
  ggplot(aes(x = as.Date(Last_Update), y = Deaths), color = Last_Update) +
  geom_point(alpha = 0.25) +
  geom_smooth(se = FALSE, method = "loess", color = "blue") +
  facet_wrap(~ Province_State, scales = "free") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+
  xlab("Date")

# IV. ####
#(Back to the full dataset) Find the “peak” of Case_Fatality_Ratio for each state and save this as a new data frame object called state_max_fatality_rate. (20 pts)
# I’m looking for a new data frame with 2 columns:
#   “Province_State”
# “Maximum_Fatality_Ratio”
# Arrange the new data frame in descending order by Maximum_Fatality_Ratio
# This might take a few steps. Be careful about how you deal with missing values!

State_Max_Fatality_Rate <- df %>% 
  group_by(Province_State) %>% 
  summarise("Maximum_Fatality_Ratio" = max(Case_Fatality_Ratio, na.rm = TRUE)) %>% 
  arrange(desc(Maximum_Fatality_Ratio))
  
   
# V. #### 
#Use that new data frame from task IV to create another plot. (20 pts)
# X-axis is Province_State
# Y-axis is Maximum_Fatality_Ratio
# bar plot
# x-axis arranged in descending order, just like the data frame (make it a factor to accomplish this)
# X-axis labels turned to 90 deg to be readable
# Even with this partial data set (not current), you should be able to see that (within these dates), different states had very different fatality ratios.

State_Max_Fatality_Rate %>% 
  ggplot(aes(x = reorder(Province_State, -Maximum_Fatality_Ratio), y = Maximum_Fatality_Ratio)) +
  geom_bar(stat = "identity")+
  theme(axis.text.x = element_text(angle = 90, vjust = 1, hjust=1))+
  labs(y = "Maximum Fatality Ratio",
       x = "Province or State")

# VI. ####
#(BONUS 10 pts) Using the FULL data set, plot cumulative deaths for the entire US over time
# You’ll need to read ahead a bit and use the dplyr package functions group_by() and summarize() to accomplish this.

df %>% 
  group_by(Last_Update) %>% 
  summarise("Cumulative_Deaths" = sum(Deaths, na.rm = TRUE)) %>% 
  ggplot(aes(x = as.Date(Last_Update), y = Cumulative_Deaths))+
  geom_bar(stat = "identity")+
  labs(x = "Date",
       y = "Cumulative Deaths in USA")


