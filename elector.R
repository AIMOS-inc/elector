library(STV) #Single Transferable Vote Counting.
library(tidyverse)
library(misinformation) #devtools::install_github("lingtax/misinformation")
#remotes::install_github("Lingtax/misinformation")

# Election rules are in the by-laws at the website aimos.community

#2021 is the first year where members are elected to the Board rather than to specific offices
#all 9 spots are up for grabs.

# Election function (set defaults) ----------------------------------------
aimos_stv <-  function(ballots, seats) {

  stv( #Analyze a data frame of STV election ballot rankings and return the elected voters and details of the steps in the election counting.
      ballots,
      seats = seats,  #How many positions are there to fill with this vote
      surplusMethod = "Fractional",
      quotaMethod = "Droop")
}


# Read ballots ------------------------------------------------------------
meta <-  read_csv("meta_election.csv")
df <-  misinformation::read_qualtrics("AIMOS_2020_election_Test.csv")
dg <- df %>% meta_rename(meta, old =  name_raw, new = name_clean)

# President ---------------------------------------------------------------
dg %>%
  select(starts_with("pres")) %>%
  as.data.frame() %>%
  aimos_stv(seats = 1)


# Vice-president ----------------------------------------------------------
dg %>%
  select(starts_with("vicepres")) %>%
  as.data.frame() %>%
  stv(seats = 1)

# Treasurer  ----------------------------------------------------------
dg %>%
  select(starts_with("treas")) %>%
  as.data.frame() %>%
  stv(seats = 1)

# Secretary ----------------------------------------------------------

dg %>%
  select(starts_with("sec")) %>%
  as.data.frame() %>%
  stv(seats = 1)

# Student representative ----------------------------------------------------------

dg %>%
  select(starts_with("student")) %>%
  as.data.frame() %>%
  stv(seats = 1)

# D & I ----------------------------------------------------------

dg %>%
  select(starts_with("div")) %>%
  as.data.frame() %>%
  stv(seats = 1)

# General ----------------------------------------------------------

# provide names of elected candidates after previous rounds
# elected <- c("", "")
dg %>%
  select(starts_with("gen")) %>%
  select(-contains(elected)) %>%
  as.data.frame() %>%
  cleanBallots() %>%
  stv(seats = 6)


