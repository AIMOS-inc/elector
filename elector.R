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

#Confirmed that turning on choice randomisation in Qualtrics doesn't screw it up

# Read ballot columnn names file, used only for renaming qualtrics file column names
meta <-  read_csv("meta_election.csv")

data_path <- here("data")
#"AIMOS_2020_election_Test.csv"
votes_file <- file.path(data_path, "AIMOS2021electionRandomiseResponses_December 1, 2021_03.29.csv")
df <-  misinformation::read_qualtrics(votes_file)

# Use Ling's function to rename the columns from the qualtrics file
dg <- df %>% misinformation::meta_rename(meta, old =  name_raw, new = name_clean)

# General election------
ballots<- dg %>%
  select(starts_with("g_")) %>% #general seats, which is the only kind there is for AIMOS from 2021
  as.data.frame()

#Pretty print candidate names
candidateNames <- stringr::str_remove(colnames(ballots),"g_")
paste(c("The candidates are:", candidateNames), collapse=" ")

#Validate ballots. Must be dataframe, not tibble
#validateBallots(ballots)  #Didn't work without cleaning first with real data because said
## [1] "Row(s): 6 do not contain any ranks."
## Error in validateBallots(ballots) :
## Please remove blank row(s), or use cleanBallots()
# I think that happened because when I first started the survey I didn't require responses

cballots <- cleanBallots(ballots)
validateBallots(cballots)

results <- cballots %>%  stv(seats = 9)
results$elected

#Pretty print winners
winners <- stringr::str_remove(results$elected,"g_")
paste(c("The winners are:", winners), collapse=" ")

#Sanity check by assessing mean rank to each candidate
colMeans(cballots)

