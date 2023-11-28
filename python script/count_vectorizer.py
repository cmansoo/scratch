# countvectorizer converts text data in to numeric data
# by representing counts of the words in a sparse matrix

import pandas as pd
from sklearn.feature_extraction.text import CountVectorizer


text = ['Hi, python is fun', 'my python practice', 'it is going to be a useful practice', 'countvectorizer converts text to numeric']
count_vect = CountVectorizer()
count_matrix = count_vect.fit_transform(text)
count_array = count_matrix.toarray()

df = pd.DataFrame(data=count_array, columns=count_vect.get_feature_names_out())
print(df)
