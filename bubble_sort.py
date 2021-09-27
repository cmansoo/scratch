import random

# bubble sort

alist = []
for i in range(10):
    alist.append(random.randint(1,10))

print(f'unsorted: {alist}')


def bubble_sort(alist):
    size = len(alist)
    for i in range(size-1):
        for j in range(0, size-i-1):
            if alist[j] > alist[j+1]:
                temp = alist[j]
                alist[j] = alist[j+1]
                alist[j+1] = temp
    return alist


print(f'sorted: {bubble_sort(alist)}')
