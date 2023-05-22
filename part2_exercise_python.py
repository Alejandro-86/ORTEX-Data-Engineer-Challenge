# -*- coding: utf-8 -*-
"""
Created on Tue Jun 14 00:57:12 2022

Ortex Data Engineer Programming Exercise - Part 2

@author: Jonathan Deiloff
"""

import pandas as pd
from datetime import timedelta

# Creation of pandas DataFrame for data analysis.
df = pd.read_csv('2017.csv', parse_dates=['inputdate', 'tradedate'], 
                 infer_datetime_format=True)

# Transform data from long to wide format to simplify analysis.
total_shares_type = df.pivot_table(index='source', columns='transactionType',
                                   values='shares',aggfunc='sum')

# Add calculated shares buy and sell ratio column.
total_shares_type['Buy Sell Ratio'] = (total_shares_type['Sell'].values / 
                                       total_shares_type['Buy'].values)

top_3_sources = total_shares_type.sort_values(by='Buy Sell Ratio',
                                              ascending=False).head(3)

print('TASK 1: The 3 top sources with the highest buy to sell transactions \
      ratio weighted by number of total shares are ' + 
      str(top_3_sources.iloc[0].name) + ', ' + str(top_3_sources.iloc[1].name)
      + ' and ' + str(top_3_sources.iloc[2].name) + '.')

# Transform data from long to wide format to simplify analysis.
grouped_currencies = df.pivot_table(index='currency', values='valueEUR', aggfunc='sum') 
grouped_currencies.sort_values(by='valueEUR', ascending=False, inplace=True)

print('TASK 2: The 3 top currencies by numerical value of trades are ' + 
      str(grouped_currencies.iloc[0].name) + ', ' + 
      str(grouped_currencies.iloc[1].name) + ' and ' + 
      str(grouped_currencies.iloc[2].name) + '.')

# Creation of a 2 weeks timedelta object for calculation of task 3.
two_weeks_delta = timedelta(days=14)

# Count total transactions where inputdate was 2 weeks after tradedate.
task_3 = (df.inputdate > df.tradedate + two_weeks_delta).sum()

print('TASK 3: The total number of transactions where inputdate was more than\
      2 weeks after tradedate is ' + str(task_3) + '.')
      
