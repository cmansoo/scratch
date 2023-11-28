import random

# bubble sort

alist = []
for i in range(10):
    alist.append(random.randint(1,10))

print(f'unsorted: {alist}')


def selection_sort(array):
    size = len(array)

    for i in range(size):
        min_index = i
        for j in range(i + 1, size):
            if array[min_index] > array[j]:
                min_index = j

        array[i], array[min_index] = array[min_index], array[i]

    return array


print(f'sorted list: {selection_sort(alist)}')


def selection_sort2(array):
    size = len(array)

    for i in range(size):
        min_index = i
        for j in range(i + 1, size):
            if array[min_index] > array[j]:
                min_index = j

        temp = array[i]
        array[i] = array[min_index]
        array[min_index] = temp

    return array


print(f'sorted list: {selection_sort2(alist)}')
