library(readxl)
library(dplyr)
df <- read_excel("Benthic_cover.xlsx")

# find out how many transects per TP
 # group by Transect_ID and TP
no.trans <- df %>%
  group_by(TP) %>%
  summarize(unique_IDs = n_distinct(Transect_ID)) # 15 transects per TP, except Dec 2020 & April 2021 only 12 transects

# total number of unique IDs
total_unique_IDs <- sum(no.trans$unique_IDs) # 84 transects in total

# unique IDs per site
no.trans.per.site <- df %>%
  group_by(TP, Site) %>%
  summarize(unique_IDs = n_distinct(Transect_ID))
  # always 6 in EB and SB, 3 in CB
