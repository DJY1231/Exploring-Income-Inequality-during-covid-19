#### Preamble ####
# Purpose: Models the raw income data for analysis
# Author: Dong Jun Yoon
# Date: 2 December, 2024
# Contact: dongjun.yoon@mail.utoronto.ca
# License: MIT
# Pre-requisites: Requires the `tidyverse` and `rstanarm` packages
# Any other information needed?

#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
analysis_data <- read_csv("data/analysis_data/analysis_data.csv")

### Model data ####
first_model <-
  stan_glm(
    formula = flying_time ~ length + width,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )


#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)


