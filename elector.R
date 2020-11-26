library(STV)
library(tidyverse)
df <-  read_csv("test-election.csv")

aimos_stv <-  function(ballots, seats) {
  
  stv(ballots,
      seats = seats, 
      surplusMethod = "Fractional", 
      quotaMethod = "Droop")
  
}

df %>% 
  select(starts_with("pres")) %>% 
  as.data.frame() %>% 
  aimos_stv(seats = 1)


df %>% 
  select(starts_with("vicepres")) %>% 
  as.data.frame() %>% 
  stv(seats = 1)
