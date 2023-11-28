import random

alist = []

for i in range(1,11):
    alist.append(i)

answer = random.randint(1,10)


#  binary search
# 1. compare x with the middle element
# 2. if x matches with the middle element, we return the mid index
# 3. else if x is greater thant the mid element, then x can only lie in the right (greater)
#     half subarray after the mid element. then we apply the algorithm again for the right half.
# 4. else if x is smaller, the target x must lie in the left (lower) half. So we apply the algorithm for the left half.


def binary_search(array, target): # returns the index of target value in an array
    left = 0
    right = len(array) - 1

    while left <= right:
        mid = left + (right - left) // 2
        mid_value = array[mid]

        if mid_value == target:
            return mid
        elif target < mid_value:
            right = mid + 1
        else:
            left = mid - 1
    return None

guess_index = binary_search(alist, answer)
guess = alist[guess_index]
print(guess_index)
print(guess, answer)
