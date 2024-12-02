#### Preamble ####
# Purpose: Cleans the raw income data for analysis
# Author: Rohan Alexander 
# Date: 2 December, 2024
# Contact: rohan.alexander@utoronto.ca 
# License: MIT
# Pre-requisites: Requires the `tidyverse` and `janitor` packages
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Clean data ####

# Load raw WID data
wid_data <- read_csv("inputs/data/WID_Data_02122024-235921.csv", skip = 4, 
                     col_names = c("Social_Class", "Year", "Share_of_total_income"),
                     col_types = cols())

# Clean WID data
wid_data_cleaned <- wid_data |>
  clean_names() |> # Ensure consistent column naming
  mutate(
    year = as.integer(year),
    share_of_total_income = as.numeric(share_of_total_income)
  ) |>
  filter(!is.na(year) & !is.na(share_of_total_income)) # Remove rows with missing values

# Load raw income inequality data
income_inequality <- read_csv("inputs/data/Income_inequality_social_class.csv")

# Clean income inequality data
income_inequality_cleaned <- income_inequality |>
  clean_names() |> 
  mutate(
    year = as.integer(year),
    share_of_total_income = as.numeric(share_of_total_income)
  ) |>
  filter(!is.na(year) & !is.na(share_of_total_income)) # Remove rows with missing values

# Merge datasets for consistency
combined_cleaned_data <- wid_data_cleaned |>
  inner_join(income_inequality_cleaned, by = "year", suffix = c("_wid", "_inequality"))

#### Save data ####
# Save cleaned datasets
write_csv(wid_data_cleaned, "outputs/data/wid_data_cleaned.csv")
write_csv(income_inequality_cleaned, "outputs/data/income_inequality_cleaned.csv")
write_csv(combined_cleaned_data, "outputs/data/combined_cleaned_data.csv")
