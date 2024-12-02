#### Preamble ####
# Purpose: Tests the integrity and validity of the cleaned income datasets
# Author: Dong Jun Yoon
# Date: 2 December, 2024
# Contact: dongjun.yoon@mail.utoronto.ca
# License: MIT
# Pre-requisites: Requires the `testthat`, `validate`, and `tidyverse` packages
# Any other information needed? Ensure the cleaned data files are saved in `outputs/data/`

#### Workspace setup ####
library(tidyverse)
library(testthat)
library(validate)

#### Test data ####

# Load the cleaned data
wid_data_cleaned <- read_csv("outputs/data/wid_data_cleaned.csv")
income_inequality_cleaned <- read_csv("outputs/data/income_inequality_cleaned.csv")

# Define test cases for WID data
test_that("WID data integrity tests", {
  # Test column names
  expect_equal(colnames(wid_data_cleaned), c("social_class", "year", "share_of_total_income"))
  
  # Test column types
  expect_type(wid_data_cleaned$social_class, "character")
  expect_type(wid_data_cleaned$year, "integer")
  expect_type(wid_data_cleaned$share_of_total_income, "double")
  
  # Test for missing values
  expect_true(all(!is.na(wid_data_cleaned$year)))
  expect_true(all(!is.na(wid_data_cleaned$share_of_total_income)))
  
  # Test value ranges
  expect_true(all(wid_data_cleaned$year >= 1900 & wid_data_cleaned$year <= 2024))
  expect_true(all(wid_data_cleaned$share_of_total_income >= 0 & wid_data_cleaned$share_of_total_income <= 1))
})

# Define test cases for income inequality data
test_that("Income inequality data integrity tests", {
  # Test column names
  expect_equal(colnames(income_inequality_cleaned), c("country", "social_class", "year", "share_of_total_income"))
  
  # Test column types
  expect_type(income_inequality_cleaned$country, "character")
  expect_type(income_inequality_cleaned$social_class, "character")
  expect_type(income_inequality_cleaned$year, "integer")
  expect_type(income_inequality_cleaned$share_of_total_income, "double")
  
  # Test for missing values
  expect_true(all(!is.na(income_inequality_cleaned$year)))
  expect_true(all(!is.na(income_inequality_cleaned$share_of_total_income)))
  
  # Test value ranges
  expect_true(all(income_inequality_cleaned$year >= 1900 & income_inequality_cleaned$year <= 2024))
  expect_true(all(income_inequality_cleaned$share_of_total_income >= 0 & income_inequality_cleaned$share_of_total_income <= 1))
})

# Additional validations with `validate`
rules <- validator(
  year >= 1900,
  year <= 2024,
  share_of_total_income >= 0,
  share_of_total_income <= 1
)

# Apply validation rules to WID data
validation_wid <- confront(wid_data_cleaned, rules)
summary(validation_wid)

# Apply validation rules to income inequality data
validation_income <- confront(income_inequality_cleaned, rules)
summary(validation_income)
