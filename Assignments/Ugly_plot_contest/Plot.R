
library(tidyverse)
library(Stat2Data)
library(magick)
library(ggblur)
library(cowplot)
library(grid)

# install.packages("devtools")
#devtools::install_github("coolbutuseless/ggblur")

#image to be used as the background
file <- './Assignments/Ugly_plot_contest/download.jpeg'

#read in image
img <- image_read(file)

#setting the dataframe to be the faithful faces dataset from stat2data
df <- FaithfulFaces

#loading a second image for the background
imag2 <- image_read("./Assignments/Ugly_plot_contest/weird-funny-cursed-images-9.jpeg")

# Flip the image vertically
flipped_image <- image_rotate(imag2, degrees = 180)

#plotting the most cursed plot yet. 
your_plot <- df %>%
  ggplot() +
  annotation_raster(img, xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf) +
  coord_fixed(ratio = 0.09) +
  geom_point_blur(aes(x = Trust, y = Cheater, color = SexDimorph)) +
  geom_col(aes(x = Attract, y = Trust, fill = Cheater)) +
  ggtitle("your mom is a liar") +
  theme(plot.title = element_text(size = 36, family = ".SF Arabic", face = "italic")) +
  labs(x = "Likelihood of your crying") +
  facet_wrap(~RaterSex) +
  scale_color_gradient(high = "#AD7252", low = "#837459", name = "quel joie") +
  labs(y = "As-tu peur?", x = "n'importe quoi") + 
  theme(axis.title.x = element_text(family = ".SF Arabic", face = "bold", angle = 65, vjust = 1.5, hjust = 1),
        axis.title.y = element_text(family = ".SF Arabic", face = "bold", angle = -185, vjust = 0.5, hjust = 1),
        strip.background = element_rect(colour = "#A77551", fill = "#A99B78")) +
  scale_x_continuous(breaks = c(-3, 3, .25)) +
  scale_y_continuous(breaks = c(-10, 3, 23)) +
  scale_fill_gradient(high = "#736841", low = "#6B5944", name = "your mom", labels = c("je", "su", "s", "sa", "ve"))

final_plot <- ggdraw() +
  draw_image(flipped_image, x = 0, y = 0, width = 1, height = 1) +
  draw_plot(your_plot, x = 0, y = 0.25, width = 1, height = 1)

ggsave("./Assignments/Ugly_plot_contest/Cursed_plot.png", dpi = 350)


