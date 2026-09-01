# DATA CLEANING

1) Load data into Python (Jupyter Notebook, VS Code)

2) Examine data spread: `df.info()`, `df.describe()`

3) Handle missing values, outliers, scaling and formatting

4) Feature Engineering: create columns as needed for clarity and information extraction

5) Connect to SQL environment (sqlite), or save cleaned dataframe and upload to Google BigQuery

# DATA WRANGLING

Exploratory analysis in SQL:

* Aggregations (GROUP BY, window functions), joins across tables, filtering edge cases, sanity-check row counts pre/post transformations

* Reshape data as needed - pivot/melt, merge/concat in pandas, or equivalent SQL (CASE WHEN pivots, UNION)

* Validate results - spot-check against source, confirm no duplicate/dropped rows, document any assumptions made

# DATA VISUALIZATION

Choose visualizing tool - matplotlib/seaborn for quick exploratory plots, Plotly for interactive, Tableau/Looker/PowerBI for stakeholder-facing dashboards

Match chart type to the question - trends over time (line), comparisons (bar), distributions (histogram/box plot), relationships (scatter), composition (stacked bar/pie sparingly)
