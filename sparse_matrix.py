# sparse matrix using triplet representation
# format: row, col, value
# top row is the dimension of the values and number or non zero values
# rest of the rows represent location and the value

import numpy as np
from scipy.sparse import csr_matrix

A = np.array([[4,3,0,0,0], [0,0,0,1,0], [2,0,0,0,4], [0,0,0,0,6]])
print(A)

# convert to sparse matrix
sparse_matrix = csr_matrix(A)
print(sparse_matrix)

# convert back to 2D matrix
B = sparse_matrix.todense()
print(B)
