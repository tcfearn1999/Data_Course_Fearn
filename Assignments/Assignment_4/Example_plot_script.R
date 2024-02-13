library(tidyverse)

labels <- c("antagonism", "facilitation","stochasity", "recipient gradient",
            "co-occurence hubs", "competition", "niche occupation")
output_data <- c(0.10, 0.95, 0.20, 0.15, 0.20, 0.25, 0.10)

df <- data.frame(output_data, labels)

df %>% ggplot(aes(x = labels, y = output_data, fill = labels))+
  geom_col()+
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+
  labs(x = "Biological Processes", y = "Output detection level")

ggsave("./Assignments/Assignment_4/Example_plot.jpg")