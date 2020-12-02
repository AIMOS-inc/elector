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

meta <-  read_csv("meta_election.csv")
df <-  read_qualtrics("AIMOS_2020_election_Test.csv")
df <- df %>% meta_rename(meta, old =  name_raw, new = name_clean)

# President ---------------------------------------------------------------

df %>% 
  select(starts_with("pres")) %>% 
  as.data.frame() %>% 
  aimos_stv(seats = 1)


# Vice-president ----------------------------------------------------------

df %>% 
  select(starts_with("vicepres")) %>% 
  as.data.frame() %>% 
  stv(seats = 1)

# Treasurer  ----------------------------------------------------------

df %>% 
  select(starts_with("treas")) %>% 
  as.data.frame() %>% 
  stv(seats = 1)

# Secretary ----------------------------------------------------------

df %>% 
  select(starts_with("sec")) %>% 
  as.data.frame() %>% 
  stv(seats = 1)

# Student representative ----------------------------------------------------------

df %>% 
  select(starts_with("student")) %>% 
  as.data.frame() %>% 
  stv(seats = 1)

# D & I ----------------------------------------------------------

df %>% 
  select(starts_with("div")) %>% 
  as.data.frame() %>% 
  stv(seats = 1)

# General ----------------------------------------------------------

# provide names of elected candidates after previous rounds
# elected <- c("", "")

df %>% 
  select(starts_with("gen")) %>% 
  select(-contains(elected)) %>%
  as.data.frame() %>%  
  cleanBallots() %>% 
  stv(seats = 6)


