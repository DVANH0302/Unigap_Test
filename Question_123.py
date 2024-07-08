# Excercise 1 
from collections import Counter
import json
def exercise_1():  
    for i in range(100):
        ls_string = ['data engineering is     awesome' for i in range(100)]
    def world_cnt(string):
        d = Counter(string.split())
        return d


    # generate 100 json files 
    for i in range(100):
        d = world_cnt(ls_string[i])
        json_object_i = json.dumps(d)
        print(json_object_i)
        
        with open(f"result_{i}.json", 'w') as outfile:
            outfile.write(json_object_i)


# Exercise 2

'''
Apply concepts similar to Slowly Changing Dimensions in Datawarehouse
Option 1: Address table with overwrite 
    - Overwrite the address of the customer  
    - Pros: 
        + Simple and easy to implement 
        + Require less storage space
    - Cons:
        + Previous adresses of customer are lost
        + Not suitable for historical analysis
    
Option 2:  Adress table with row versioning
    - Maintains the history of changes in the dimension table by creating a new records
      for each change. New dimension(s) (column(s)) are created to track the historical change. 
    - Example: add `is_active` column where 1 represents the current address and 0 represents all the previous addresses 
    - Pros:
        + Supporting historical analysis
        + No data is lost
    - Cons:
        + More storage space
        + Complex to implement

Option 3: Adress table with column versioning
    - Store previous address in a column without adding new records 
    - Pros:
        + Less storage space compared to option_2
        + Faster queries 
    - Cons:
        + Not provide complete history of changes 

REF: https://python.plainenglish.io/understanding-slowly-changing-dimensions-scd-in-data-warehousing-20a566ae3fdd


'''

# exercise 3:
import pandas as pd 

df = pd.read_json('data.json')
df['join_date'] = pd.to_datetime(df['join_date'])
df.info()

# Exercise 4 
import pyodbc
import pandas as pd

# 1,2,3,4
# 5 No experience. 

server = '????????' # ENTER YOUR SERVER NAME 
database = '???????' # ENTER YOUR DATABASE NAME 

cnxn = pyodbc.connect('DRIVER={SQL Server Native Client 11.0};SERVER='+server+';DATABASE='+database+';Trusted_Connection=yes;')
cursor = cnxn.cursor()

#Insert Dataframe into SQL Server:
for index, row in df.iterrows():
    cursor.execute("INSERT INTO employees (id, name, department, salary, join_date) VALUES (?, ?, ?, ?, ?)",
                   row['id'], row['name'], row['department'], row['salary'], row['join_date'])

cnxn.commit()
cursor.close()

# REF: https://learn.microsoft.com/en-us/sql/machine-learning/data-exploration/python-dataframe-sql-server?view=sql-server-ver16





