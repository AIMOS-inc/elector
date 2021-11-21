library(STV) #Single Transferable Vote Counting.
library(tidyverse)
library(misinformation) #devtools::install_github("lingtax/misinformation")
#remotes::install_github("Lingtax/misinformation")
library(here)

#See the README file for more information


# Election function (set defaults) ----------------------------------------
aimos_stv <-  function(ballots, seats) {

  stv( #Analyze a data frame of STV election ballot rankings and return the elected voters and details of the steps in the election counting.
      ballots,
      seats = seats,  #How many positions are there to fill with this vote
      surplusMethod = "Fractional",
      quotaMethod = "Droop")
}

#NOT SURE CHOICE RANDOMSIATION WILL WORK

# Read ballot columnn names file, used only for renaming qualtrics file column names
meta <-  read_csv("meta_election.csv")

data_path <- here("data")
votes_file <- file.path(data_path, "AIMOS2021election_November 20, 2021_19.16.csv")

#df <-  misinformation::read_qualtrics("AIMOS_2020_election_Test.csv")
df <-  misinformation::read_qualtrics(votes_file)

# Use Ling's function to rename the columns from the qualtrics file
dg <- df %>% misinformation::meta_rename(meta, old =  name_raw, new = name_clean)


# General election------



#Validate ballots. To do so, have to clean ballots first
ballots<- dg %>%
  select(starts_with("gen")) %>% #general seats, which is the only kind there is for AIMOS from 2021
  as.data.frame()

validateBallots(ballots)
#cballots <- cleanBallots(ballots)

ballots %>%  stv(seats = 1)


