# Tableau questions:
1. Convert the necessary measures to dimensions (the variables that are categorical in nature)
2. Plot the distribution of `price` vs. _number of bedrooms_, `price` vs. _number of bathrooms_, `price` vs. _condition_, `price` vs. _floors_, `price` vs. _grade_, `price` vs. _view_, and `price` vs. _waterfront_.
   State your observation for each one of those graphs. Do you see any trends in prices vs the rest of those variables individually? This can also be used for EDA to identify some data cleaning operations that you might need to perform further.
3. Draw scatter plots for `price` vs. `sqft_above`, `price` vs. `sqft_basement`, `price` vs. `living15`, `price` vs. `sqft_lot15`.
4. Identify using tableau which state data is presented to you. Use latitude (generated), longitude (generated), and zip code for this. Color code the zip codes based on the prices to see which areas are more expensive than the others.
5. Create a plot to check which are the more selling properties based on the number of bedrooms in the house. Create a plot of bedrooms vs. count of data points.
6. We want to see the trend in price of houses based on the year built. From our previous plot, we know that most of our customers are interested in three and four bedroom houses. Create a filter on bedroom feature to select those properties and compare the trends in prices using line charts.
7. Create calculated field `year_built_bins` for the column `year_built` by creating buckets as follows, for houses built between 1900 and 2000 - category A, for houses built between 2000 and 2010 - category B, and for houses built after 2010 - category C. Use `IF-ELSE` statement to create the bins/buckets. Compare the prices of houses for the three categories.
8. Now we want to deep dive into the categories we created in the last question. Let’s see how many properties are in each of the categories. Indicate the numbers as labels on each of the three categories.
9. Deep dive in category A, category B and category C using filters. Identify different characteristics/trends for each of the three categories.
10. Create a visually appealing dashboard to represent the information. 
# My answers:
The whole Tableau story can be found [here](https://public.tableau.com/app/profile/hajar1648/viz/house_price_project_visualization/ProjectVisualization) (use full screen). It is important to mention, that the cleaned data was used as a source for visualizations. Therefore, some answers can vary according to the data (will be explained below).

1. All measures, except Price, Sqft Living and Sqft Lot were converted to dimensions. The reason is few unique values, which can be considered as categories. 
2. The given independent variables can be divided into 2 parts: 
* Features - include Grade, Condition, View and Waterfront variables, which kind of evaluate the Property.
* Details - include Number of Bedrooms, Bathrooms and Floors, which describe the Property.
<img width="806" alt="Screen Shot 2022-02-26 at 10 48 48" src="https://user-images.githubusercontent.com/94174764/155838523-fcf084e5-3862-4522-b744-db178bf05bb4.png">

From the bar graphs above we can compare Average Price with Features. The labels on bars indicate number of houses and the color gets darker as this number increases. My observations are as following:
* Average __Condition__ mark (3) has more than half number of houses and its average price is little lower than the highest Condition mark (5).
* As for the __Grade__, we observe gradual increase starting from the middle (7). The more is grade the higher is the average price. Most of the values fall to the middle points. When we compare the trends on average price, we see that the grade of house causes significant incease on the average price, reaching the value of about 4 million.
* The variable __View__ seems to be irrelevant for further EDA, as more than 90% of houses are concerned to have no view, which doesn't make sense.
* The same with __Waterfront__ variable. Despite the fact that only 163 houses have view to waterfront, the average price is 3 times more than the houses with no waterfront.
<img width="816" alt="Screen Shot 2022-02-26 at 12 03 42" src="https://user-images.githubusercontent.com/94174764/155840808-a7db0f99-415b-4ec9-8573-46e0cb92c8f8.png">

* From the graphs we see that most popular houses are those with __3 or 4 Bedrooms__ and __1 or 2 Bathrooms__, which average price is around half million.
* When we look at the __Number of Bedrooms__ graph we see a steady increase till the number reaches 8, which is the peak on the average price (more than million), and then we observe a decrease as the number gets more. The few number of houses with 9 or 10 bedrooms can indicate a low demand and hence lower average price.
* Among 3 graphs above, the __Number of Bathrooms (grouped)__ give the most rise to average price (from about 400 thousand to about 5 million).
* In case with the __Number of Floors__ unexpected decrease of average price on the number 3 was observed. The average price stops to increase on the 2,5 number of floors. From the graph we see that the most prefered house are with 1 or 2 floors.
