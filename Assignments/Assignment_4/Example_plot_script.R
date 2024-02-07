library(tidyverse)

labels <- c("antagonism", "facilitation","stochasity", "recipient gradient",
            "co-occurence hubs", "competition", "niche occupation")
output_data <- c(0.10, 0.95, 0.20, 0.15, 0.25, 0.30, 0.10)

df <- data.frame(output_data, labels)

ggplot()