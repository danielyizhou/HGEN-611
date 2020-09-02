# Homework 2 - Missingness, Data Extraction, and the Beginnings of Plotting
#
#
#
# Credit to David Robinson for some of the plot ideas (esp plots 6 and 7)
# and to Allison Horst and Allison Hill fodr creating such a wonderful resource:
# the palmer penguin package and its associated documentation.
#
################################################################################


# Due dates: -----
# Initial submission is due by Friday September 4th at 5PM. 
# The answer key will become available Friday September 4th by 8PM.
# The metacognition will be due by Tuesday September 8th at 5PM. 

# Submissions received by Wednesday September 2nd at 5PM will be eligible
# for an additional 10 points (i.e., 70/60). To earn these points,
# the submitted work must demonstrate both thoughtfulness and accuracy.






# Key practices to get the most benefit from doing this homework:

# 1) Space out the problems over a few days. 
# 2) In swirl, do not simply copy and paste the code. Get practice typing it out.
# 3) When you get to the figures, plot each one and really look at it. You should
#    start to see how to link variables in your dataset to plot characteristics and
#    aesthetics.



# Part 1 Swirl --------------------------------------------------------------------

library("swirl")
swirl()


# Complete Lessons 5: Missing Values (~10 minutes), 6: Subsetting Vectors (~20 minutes),
# 7: Matrices and Data Frames (~20 minutes), and 12: Looking at Data (~10 minutes)


# For each lesson you complete, type out the honor pledge below declaring that you have
# completed the lesson.

# On my honor, I completed Lesson 5: Missing Values.
# On my honor, I completed Lesson 6: Subsetting Vectors.
# On my honor, I completed Lesson 7: Matrices and Data Frames.
# On my honor, I completed Lesson 12: Looking at Data.

# Part 2 Unleash the Penguins! ------------------------------------------------------------

# Use the code below to install the palmerpenguins package and then load the tidyverse and
# palmerpenguins packages.

install.packages("palmerpenguins")

library(tidyverse)
library(palmerpenguins)


# load the penguins dataset.  
data("penguins")



# Let's look at the penguins dataset. Ignore penguins_raw for now. 
penguins


# For each question below, use comments to answer the question and show
# the code that you used to get the answer.


# 1. How many unique species of penguins are represented? How many penguins are in each species?


# 2. How many unique islands are represented in the dataset? Are these islands real places?
#    (Hint: check the help page)


# 3. Do any of the islands have more than one species of penguin that live there?
#    (Hint: table() can count multiple variables)


# 4. Create a new data.frame called my_gentoo that contains only Gentoo penguins
#    that live on Biscoe Island. What is the average bill length for those penguins?



# 5. Let's say you wanted to get an idea of how much each species varied by weight.
#    Typing all of that out using base R (i.e., non-tidyverse style code) would take 
#    forever. It also would be less interesting than looking at a plot.

#    Below, I am going to create plots. Your job will be to explain what each 
#    part of the code is doing. This process is akin to learning to read. The
#    point of this exercise is that when you were a child learning how to read,
#    no one expected you to read and write children's books simultaneously. 
#    It's the same idea here. I want you to become comfortable recognizing 
#    vocabulary like "geom_point" so that when the time comes for you to make 
#    figures, you are ready to rock and roll!

# Example
ggplot(penguins) +
  geom_point(aes(bill_length_mm, bill_depth_mm, 
                 color = species))

# Explanation: This code generates a scatterplot comparing bill length to 
#              bill depth. The color of the points corresponds to species.



# Plot 1 ----
ggplot(penguins) +
  geom_bar(aes(species)) 




# Plot 2 ----
ggplot(penguins) +
  geom_point(aes(flipper_length_mm, body_mass_g, 
                 shape = species, 
                 color = sex), size = 2) +
  theme_light()




# Plot 3 ----
ggplot(penguins[penguins$species == "Chinstrap", ], 
       aes(bill_depth_mm, bill_length_mm)) +
  geom_point(size = 2) +
  geom_quantile(color = "blue", 
                lwd = 2, 
                alpha = 0.5) +
  theme_classic()





# Plot 4 ----
ggplot(penguins, aes(bill_length_mm, bill_depth_mm, 
                     color = species)) +
  geom_point() + 
  geom_smooth(method = "lm", 
              se = FALSE)




# Plot 5 ----
ggplot(penguins, aes(flipper_length_mm, bill_length_mm, 
                     color = species, shape = species)) +
  geom_point() +
  scale_colour_manual(values = c("darkorange","purple","cyan4")) +
  xlab("Flipper Length (mm)") +
  ylab("Bill Length (mm)") +
  theme_classic() +
  ggtitle("My plot",subtitle = "Penguins on Parade")
    # Credit to Allison Horst & Allison Hill for picking great colors (https://education.rstudio.com/blog/2020/07/palmerpenguins-cran)



# Plot 6 ----
# Remember: you are looking at the code to become comfortable looking at 
# this language. It is okay if you don't know all of the functions.
# For now, when you look at this code, realize that there are functions out there
# that reshape your data and weird symbols (%>%) that connect code lines
# like plus signs. Your focus is on the figure. It has four panels. 
# What does each panel show you (Hint: look at the labels)? 

penguins %>% 
  pivot_longer(cols = bill_length_mm:body_mass_g,
               names_to = "physical_characteristic",
               values_to = "value") %>% 
  ggplot(aes(species, value, fill = species)) +
  geom_boxplot() +
  facet_wrap(~physical_characteristic, scales = "free_y") +
  theme_bw()





# Plot 7 ----
# This plot is a density plot. Density plots can be useful when 
# you have categories that are not all well-represented. In our
# case, we do not have many of one species of penguin, so a density
# plot helps us compare the distributions of variables. 

# What does this plot illustrate? How might this visualization be useful?
# (Hint: Look at the bill_depth_mm panel. If I told you that I had found
# a penguin with a bill depth of 14mm, you should have a good guess 
# as to what kind of penguin I found.)

penguins %>% 
  pivot_longer(cols = bill_length_mm:body_mass_g,
               names_to = "physical_characteristic",
               values_to = "value") %>% 
  ggplot(aes(value, fill = species)) +
  geom_density(alpha = 0.3) +
  facet_wrap(~physical_characteristic, scales = "free")





# Part 3 Putting it all together ------------------------------------------------------------------

#    I've been thinking about Plot 2, and I'm not sure that the figure actually
# is as clear as I'd like it to be. My goal is to be able to look at the graph
# and immediately to see that the Gentoo penguins are the heaviest.

# Experiment with the figure aesthetics. Can you find a better mapping arrangement
# to illustrate the differential body mass by species? While you are at it, 
# could you 

# a) make a new data.frame called penguins_noNA that contains no missing values 
# b) change the x and y labels so that they are real words and not variable names
# c) add a professional title to the plot that reflects the data shown




