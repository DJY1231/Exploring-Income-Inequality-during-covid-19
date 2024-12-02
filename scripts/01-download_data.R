#### Preamble ####
# Purpose: Downloads and saves the data from an online source or reads local files
# Author: Dong Jun Yoon
# Date: 2 December, 2024
# Contact: dongjun.yoon@mail.utoronto.ca
# License: MIT
# Pre-requisites: Ensure the `tidyverse` package is installed
# Any other information needed? https://wid.world/data/ (download the dataset if needed, or go to rawdata)

#### Workspace setup ####
library(tidyverse)

#### Download data ####
# If your dataset is hosted online, use `read_csv()` with the dataset URL:
# Replace "URL_TO_DATASET" with the actual URL to your dataset

# Example for downloading online data:
# the_raw_data <- read_csv("URL_TO_DATASET")

# Example for loading local data (update file path if needed):
wid_data <- read_csv("path/to/WID_Data_02122024-235921.csv", skip = 4, col_names = c("Social_Class", "Year", "Share_of_total_income"), col_types = cols())
income_inequality <- read_csv("path/to/Income_inequality_social_class.csv")

#### Save data ####
# Save the datasets for reproducibility
write_csv(wid_data, "outputs/data/wid_data_cleaned.csv")
write_csv(income_inequality, "outputs/data/income_inequality_cleaned.csv")

         
