#!/usr/bin/env python
# coding: utf-8

# In[2]:


#importing the relevant libraries
import pandas as pd


# In[3]:


#importing the csv dataset using the parh link
df = pd.read_csv(r"C:\Users\Administrator\Downloads\supermarket_large_dataset.csv")


# In[4]:


#confirming the dows and columns
df.head()


# In[8]:


# 2. Define the columns you actually need for this project and SQL
columns_to_keep = [
    'customer_id', 'transaction_date', 'product_name', 'product_category', 
    'store_id', 'quantity', 'unit_price', 'total_amount', 
    'payment_method', 'promotion_active', 'is_holiday', 'inflation_index'
]


# In[10]:


# 3. Filter the dataset
df_clean = df[columns_to_keep].copy()


# In[11]:


# 6. Export to a new, clean CSV file
df_clean.to_csv('kenya_retail_clean.csv', index=False)


# In[12]:


print("Success! Exported", len(df_clean), "rows to kenya_retail_clean.csv")
print(df_clean.head())


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




