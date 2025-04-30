# iris_analysis.py

import pandas as pd
import seaborn as sns


iris = sns.load_dataset('iris')

print("First 5 rows of the dataset:")
print(iris.head())

# Check data types and missing values
print("\nDataset info:")
print(iris.info())

print("\nMissing values in each column:")
print(iris.isnull().sum())

# Drop missing values if any
iris_cleaned = iris.dropna()
print("\nShape after dropping missing values:", iris_cleaned.shape)


# Summary statistics
print("\nSummary statistics of numerical columns:")
print(iris_cleaned.describe())

# Group by species and compute mean petal length
print("\nAverage petal length by species:")
mean_petal_length = iris_cleaned.groupby('species')['petal_length'].mean()
print(mean_petal_length)

# Additional insight: mean sepal width by species
print("\nAverage sepal width by species:")
mean_sepal_width = iris_cleaned.groupby('species')['sepal_width'].mean()
print(mean_sepal_width)
