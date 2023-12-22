import pandas as pd


# Read the data from the csv file
df = pd.read_csv('2017.csv')

## Exercise 1
# Select the columns of interest and filter out the rows with transactionType other than Buy or Sell

df1 = df[['source', 'transactionType', 'shares']]
mask = df1['transactionType'].isin(['Buy','Sell'])
df1 = df1[mask]

# Group by source and transactionType and sum the shares
df1['buy_operations'] = (df1['transactionType'] == 'Buy').astype(int)
df1['sell_operations'] = (df1['transactionType'] == 'Sell').astype(int)
df1['shares_buy'] = (df1['transactionType'] == 'Buy').astype(int)* df1['shares']
df1['shares_sell'] = (df1['transactionType'] == 'Sell').astype(int)* df1['shares']
df1 = df1.drop(['transactionType', 'shares'], axis=1)
df1 = df1.groupby('source').sum().reset_index()

# Calculate the ratio and print the top 3
df1['ratio'] = (df1['buy_operations']/df1['buy_operations'])*(df1['shares_buy']/df1['shares_sell'])
df1 = df1[['source','ratio']].sort_values(by='ratio',ascending=False)[:3]
print(df1['source'])
print('------------------')

## Exercise 2

# Count the number of transactions for each currency and print the top 3
df2 = df[['currency']].value_counts()[:3]
print(df2)
print('------------------')

# Exercise 3

# Convert the inputdate and tradedate columns to datetime format
df3 = df[['inputdate', 'tradedate']]
df3 = df3.apply(pd.to_datetime, format="%Y%M%d")
# Create a mask to filter out the rows where inputdate is greater than tradedate + 14 days
mask = df3['inputdate'] > (df3['tradedate'] + pd.Timedelta(days=14))
print(df3[mask]['inputdate'].count())
print('------------------')