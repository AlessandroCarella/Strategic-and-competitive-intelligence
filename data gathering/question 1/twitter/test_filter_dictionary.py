import pandas as pd

# Assuming your dataset is stored in a pandas DataFrame named 'df'
# and your list of words is stored in a list named 'word_list'

# Sample DataFrame
data = {
    'subjects': ['math', 'science', 'history', 'biology'],
    'objects': ['book', 'pen', 'computer', 'microscope'],
    'topic': ['algebra', 'chemistry', 'revolution', 'cell'],
    'other_column': ['value1', 'value2', 'value3', 'value4']
}

df = pd.DataFrame(data)

print (df)
print ()
# List of words
word_list = ['math', 'pen', 'revolution']

# Filtering the DataFrame
filtered_df = df[df['subjects'].str.contains('|'.join(word_list)) |
                 df['objects'].str.contains('|'.join(word_list)) |
                 df['topic'].str.contains('|'.join(word_list))]

print(filtered_df)
