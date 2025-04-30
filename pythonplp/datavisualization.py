import matplotlib.pyplot as plt

plt.figure(figsize=(8, 5))
plt.plot(iris_cleaned.index, iris_cleaned['sepal_length'], label='Sepal Length')
plt.title('Simulated Trend of Sepal Length')
plt.xlabel('Index')
plt.ylabel('Sepal Length (cm)')
plt.legend()
plt.show()

avg_petal_length = iris_cleaned.groupby('species')['petal_length'].mean()
avg_petal_length.plot(kind='bar', color='skyblue', title='Average Petal Length by Species')
plt.xlabel('Species')
plt.ylabel('Average Petal Length')
plt.show()


iris_cleaned['petal_width'].plot(kind='hist', bins=20, color='orange', edgecolor='black')
plt.title('Distribution of Petal Width')
plt.xlabel('Petal Width (cm)')
plt.show()

colors = {'setosa':'red', 'versicolor':'green', 'virginica':'blue'}
plt.figure(figsize=(8, 6))
for species in iris_cleaned['species'].unique():
    subset = iris_cleaned[iris_cleaned['species'] == species]
    plt.scatter(subset['sepal_length'], subset['petal_length'],
                color=colors[species], label=species)

plt.title('Sepal Length vs Petal Length by Species')
plt.xlabel('Sepal Length (cm)')
plt.ylabel('Petal Length (cm)')
plt.legend()
plt.show()
