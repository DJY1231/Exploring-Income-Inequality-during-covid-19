#### Preamble ####
# Purpose: Simulate and analyze income distribution trends and social class interactions from 2000–2024
# Author: Dong Jun Yoon
# Date: December 2nd, 2024
# Contact: dongjun.yoon@mail.utoronto.ca
# License: MIT
# Pre-requisites: Requires `pandas`, `numpy`, and `matplotlib`
# Data sources: WID Data and Income Inequality Social Class Data

# Import libraries
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Set seed for reproducibility
np.random.seed(123)

# Load datasets
wid_data = pd.read_csv('WID_Data_02122024-235921.csv', skiprows=4, sep=";")
income_inequality = pd.read_csv('Income_inequality_social_class.csv')

# Clean and preprocess data
wid_data.columns = ['Social_Class', 'Year', 'Share_of_total_income']
wid_data['Year'] = wid_data['Year'].astype(int)
wid_data['Share_of_total_income'] = wid_data['Share_of_total_income'].astype(float)

income_inequality['Year'] = income_inequality['Year'].astype(int)

# Combine datasets for comparison
combined_data = pd.merge(
    wid_data,
    income_inequality,
    on='Year',
    suffixes=('_wid', '_inequality')
)

# Simulate random income data within ranges for different social classes
social_classes = ["Top 10%", "Top 1%", "Median Income", "Lower 10%"]
years = combined_data['Year'].unique()
n = len(years) * len(social_classes)

simulated_data = pd.DataFrame({
    'Year': np.repeat(years, len(social_classes)),
    'Social_Class': social_classes * len(years),
    'Income': np.round(np.random.uniform(20000, 500000, n), 2),
    'Share_of_total_income': np.random.uniform(0.05, 0.5, n)
})

# Create interactions between variables
simulated_data['Weighted_Income'] = simulated_data['Income'] * simulated_data['Share_of_total_income']
simulated_data['Growth_Rate'] = simulated_data.groupby('Social_Class')['Income'].pct_change().fillna(0)

# Visualize trends over time
plt.figure(figsize=(10, 6))
for cls in social_classes:
    subset = simulated_data[simulated_data['Social_Class'] == cls]
    plt.plot(subset['Year'], subset['Income'], label=cls)

plt.title("Simulated Income Trends by Social Class (2000–2024)")
plt.xlabel("Year")
plt.ylabel("Income ($)")
plt.legend()
plt.show()

# Save simulated data to CSV
simulated_data.to_csv('simulated_income_data.csv', index=False)

