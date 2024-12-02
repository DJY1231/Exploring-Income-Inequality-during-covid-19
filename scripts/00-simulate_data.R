#### Preamble ####
# Purpose: Simulate and analyze income distribution trends and social class interactions from 2000–2024
# Author: Dong Jun Yoon
# Date: December 2nd, 2024
# Contact: dongjun.yoon@mail.utoronto.ca
# License: MIT
# Pre-requisites: Requires `tidyverse`, `lubridate`
# Data sources: WID Data and Income Inequality Social Class Data

# Load libraries
library(tidyverse)
library(lubridate)

# Set seed for reproducibility
set.seed(123)

# Load datasets
wid_data <- read_csv("WID_Data_02122024-235921.csv", skip = 4, col_names = c("Social_Class", "Year", "Share_of_total_income"), col_types = cols())
income_inequality <- read_csv("Income_inequality_social_class.csv")

# Data cleaning and preprocessing
wid_data <- wid_data %>%
  mutate(
    Year = as.integer(Year),
    Share_of_total_income = as.numeric(Share_of_total_income)
  )

income_inequality <- income_inequality %>%
  mutate(
    Year = as.integer(Year)
  )

# Combine datasets
combined_data <- wid_data %>%
  inner_join(income_inequality, by = "Year", suffix = c("_wid", "_inequality"))

# Simulate random income data
social_classes <- c("Top 10%", "Top 1%", "Median Income", "Lower 10%")
years <- unique(combined_data$Year)

simulated_data <- expand.grid(
  Year = years,
  Social_Class = social_classes
) %>%
  mutate(
    Income = round(runif(nrow(.), 20000, 500000), 2),
    Share_of_total_income = runif(nrow(.), 0.05, 0.5),
    Weighted_Income = Income * Share_of_total_income
  )

# Calculate interactions
simulated_data <- simulated_data %>%
  group_by(Social_Class) %>%
  mutate(
    Growth_Rate = round((Income / lag(Income) - 1) * 100, 2),
    Growth_Rate = ifelse(is.na(Growth_Rate), 0, Growth_Rate)
  )

# Visualize trends over time
simulated_data %>%
  ggplot(aes(x = Year, y = Income, color = Social_Class)) +
  geom_line(size = 1) +
  labs(
    title = "Simulated Income Trends by Social Class (2000–2024)",
    x = "Year",
    y = "Income ($)"
  ) +
  theme_minimal()

# Save simulated data
write_csv(simulated_data, "simulated_income_data.csv")
