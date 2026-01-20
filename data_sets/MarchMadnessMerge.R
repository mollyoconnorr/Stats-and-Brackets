install.packages("readr")
install.packages("tidyverse")
install.packages("dplyr")
library(tidyverse)
library(dplyr)
kenPom <- read_csv("~/Desktop/DS-SeniorProject/March_Madness.csv")
marchResults <- read_csv("~/Desktop/DS-SeniorProject/Revised_Tournament_Matchups.csv")


kenPom <- kenPom %>%
  rename(team = 'Mapped ESPN Team Name',  year = 'Season') %>%
  filter(`Post-Season Tournament` == "March Madness", `year` >= 2008)

marchResults <- marchResults %>%
  filter(`CURRENT ROUND` == 64)

marchResults <- marchResults %>%
  rename(team = 'TEAM', year = 'YEAR')

# Teams in kenPom not in marchResults, alphabetically
sort(setdiff(unique(kenPom$team), unique(marchResults$team)))

# Teams in marchResults not in kenPom, alphabetically
sort(setdiff(unique(marchResults$team), unique(kenPom$team)))

kenPom$team <- recode(kenPom$team,
                      "Alabama State" = "Alabama St.",
                      "American University" = "American",
                      "Arizona State" = "Arizona St.",
                      "Arkansas-Pine Bluff" = "Arkansas Pine Bluff",
                      
                      "Boise State" = "Boise St.",
                      "Cal State Bakersfield" = "Cal St. Bakersfield",
                      "Cal State Fullerton" = "Cal St. Fullerton",
                      "Cal State Northridge" = "Cal St. Northridge",
                      "Charleston" = "College of Charleston",
                      "Cleveland State" = "Cleveland St.",
                      "Colorado State" = "Colorado St.",
                      
                      "Detroit Mercy" = "Detroit",
                      "East Tennessee State" = "East Tennessee St.",
                      "Florida State" = "Florida St.",
                      "Fresno State" = "Fresno St.",
                      "Gardner-Webb" = "Gardner Webb",
                      "Georgia State" = "Georgia St.",
                      "Grambling" = "Grambling St.",
                      
                      "Indiana State" = "Indiana St.",
                      "Iowa State" = "Iowa St.",
                      "Jacksonville State" = "Jacksonville St.",
                      "Kansas State" = "Kansas St.",
                      "Kennesaw State" = "Kennesaw St.",
                      "Kent State" = "Kent St.",
                      "Long Beach State" = "Long Beach St.",
                      
                      "Long Island University" = "LIU Brooklyn",
                      "Louisiana" = "Louisiana Lafayette",
                      "Loyola Maryland" = "Loyola MD",
                      "McNeese" = "McNeese St.",
                      "Miami" = "Miami FL",
                      "Michigan State" = "Michigan St.",
                      "Mississippi State" = "Mississippi St.",
                      "Mississippi Valley State" = "Mississippi Valley St.",

                      "Montana State" = "Montana St.",
                      "Morehead State" = "Morehead St.",
                      "Morgan State" = "Morgan St.",
                      "Murray State" = "Murray St.",
                      "NC State" = "North Carolina St.",
                      "New Mexico State" = "New Mexico St.",
                      "Norfolk State" = "Norfolk St.",
                      
                      "North Dakota State" = "North Dakota St.",
                      "Northwestern State" = "Northwestern St.",
                      "Ohio State" = "Ohio St.",
                      "Oklahoma State" = "Oklahoma St.",
                      "Ole Miss" = "Mississippi",
                      "Omaha" = "Nebraska Omaha",
                      "Oregon State" = "Oregon St.",
                      
                      "Penn State" = "Penn St.",
                      "Pennsylvania" = "Penn",
                      "Portland State" = "Portland St.",
                      "Sam Houston" = "Sam Houston St.",
                      "San Diego State" = "San Diego St.",
                      "South Dakota State" = "South Dakota St.",

                      "St. Francis (PA)" = "Saint Francis",
                      "Texas A&M-Corpus Christi" = "Texas A&M Corpus Chris",
                      "UAlbany" = "Albany",
                      "UConn" = "Connecticut",
                      "Utah State" = "Utah St.",
                      "Washington State" = "Washington St.",
                      "Weber State" = "Weber St.",
                      "Wichita State" = "Wichita St.",
                      "Wright State" = "Wright St."
              
)


setdiff(unique(kenPom$team), unique(marchResults$team))
setdiff(unique(marchResults$team), unique(kenPom$team))

teams_to_remove <- c("Lamar", "North Florida", "New Orleans", 
                     "Prairie View A&M", "App State", 
                     "Southeast Missouri State", "Coppin State")

# Filter them out
kenPom <- kenPom %>%
  filter(!team %in% teams_to_remove)

setdiff(unique(kenPom$team), unique(marchResults$team))


combined_data <- kenPom %>%
  left_join(marchResults, by = c("year", "team"))

combined_data <- combined_data %>%
  mutate(round_label = case_when(
    ROUND == 64 ~ "R64 Exit",
    ROUND == 32 ~ "R32 Exit",
    ROUND == 16 ~ "Sweet 16",
    ROUND == 8  ~ "Elite 8",
    ROUND == 4  ~ "Final Four",
    ROUND == 2  ~ "Runner-Up",
    ROUND == 1  ~ "Champion",
    TRUE        ~ NA_character_
  ))

combined_data <- combined_data %>%
  mutate(first_round_win = ifelse(ROUND == 64, 0, 1))

write_csv(combined_data, "~/Desktop/DS-SeniorProject/New_Combined_MarchMadness_Data.csv")




