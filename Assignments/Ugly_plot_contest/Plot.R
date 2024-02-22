install.packages("tidyverse")

library(tidyverse)
library(Stat2data)


your_plot <- your_data %>%
  ggplot() +
  annotation_raster(img, xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf) +
  coord_fixed(ratio = 0.09) +
  geom_point_blur(aes(x = Trust, y = Cheater, color = SexDimorph)) +
  geom_col(aes(x = Attract, y = Trust, fill = Cheater)) +
  ggtitle("your mom is a liar") +
  theme(plot.title = element_text(size = 36, family = ".SF Arabic", face = "italic")) +
  labs(x = "Likelihood of your crying") +
  facet_wrap(~RaterSex) +
  scale_color_gradient(high = "#AD7252", low = "#837459") +
  scale_fill_gradient(high = "#736841", low = "#6B5944", name = "Custom Legend Title", labels = c("Custom Label 1", "Custom Label 2", "Custom Label 3")) +
  labs(y = "As-tu peur?", x = "n'importe quoi") + 
  theme(axis.title.x = element_text(family = ".SF Arabic", face = "bold", angle = 65, vjust = 1.5, hjust = 1),
        axis.title.y = element_text(family = ".SF Arabic", face = "bold", angle = -185, vjust = 0.5, hjust = 1),
        strip.background = element_rect(colour = "#A77551", fill = "#A99B78")) +
  scale_x_continuous(breaks = c(-3, 3, .25)) +
  scale_y_continuous(breaks = c(-10, 3, 23))