library(STV)
library(tidyverse)
library(misinformation) #remotes::install_github("Lingtax/misinformation)


# Election function (set defaults) ----------------------------------------

aimos_stv <-  function(ballots, seats) {
  
  stv(ballots,
      seats = seats, 
      surplusMethod = "Fractional", 
      quotaMethod = "Droop")
  
}


# Read ballots ------------------------------------------------------------

meta <-  read_csv("meta_election_2021.csv")
df <-  read_qualtrics("AIMOS_2021_Election.csv")
df <- df %>% meta_rename(meta, old =  name_raw, new = name_clean)

# President ---------------------------------------------------------------

df %>% 
  select(starts_with("pres")) %>% 
  as.data.frame() %>% 
  cleanBallots() %>% 
  aimos_stv(seats = 1)


# Vice-president ----------------------------------------------------------
# This position is uncontested in 2020-2021
# The incoming VP is Susan Dilara Tokac
# 
# df %>% 
#   select(starts_with("vicepres")) %>% 
#   as.data.frame() %>% 
#   stv(seats = 1)

# Treasurer  ----------------------------------------------------------

df %>% 
  select(starts_with("treas")) %>% 
  as.data.frame() %>% 
  cleanBallots() %>% 
  stv(seats = 1)

# Secretary ----------------------------------------------------------
# This position is uncontested in 2020-2021
# The incoming Secretary is the Returning foundation secretary Martin Bush  
# df %>% 
#   select(starts_with("sec")) %>% 
#   as.data.frame() %>% 
#   stv(seats = 1)
# 
# Student representative ----------------------------------------------------------
# This position is uncontested in 2020-2021
# The incoming Student representative is Carmelina Contarino
# df %>% 
#   select(starts_with("student")) %>% 
#   as.data.frame() %>% 
#   stv(seats = 1)
# 
# D & I ----------------------------------------------------------
# This position is uncontested in 2020-2021
# The incoming Diversity and Inclusion officer is Jay Patel
# df %>% 
#   select(starts_with("div")) %>% 
#   as.data.frame() %>% 
#   stv(seats = 1)

# General ----------------------------------------------------------

# provide names of elected candidates after previous rounds
elected <- c(
  "Jason", 
  #"Matthew",
  #"Alex",
  "Rose"
  )

df %>% 
  select(starts_with("gen")) %>% 
  select(-contains(elected)) %>%
  as.data.frame() %>%  
  cleanBallots() %>% 
  stv(seats = 4)


