#finds the maximum valued digit within an integer
def max1(num):
    arr = []
    length = len(str(num))
    for i in range(length):
        arr.append(num % 10)
        num = num // 10

    maxnum = 0
    for a_num in arr:
        if a_num > maxnum:
            maxnum = a_num

    return maxnum

  
#find the max in an array
def max2(arr):
    maxnum = 0
    for a_num in arr:
        if maxnum < a_num:
            maxnum = a_num
    return maxnum
 
  
#finds the minimum valued digit within an integer
def min1(num):
    arr = []
    length = len(str(num))
    for i in range(length):
        arr.append(num % 10)
        num = num // 10

    minnum = 10
    for a_num in arr:
        if a_num < minnum:
            minnum = a_num

    return minnum

  
# find the min in an array
def min2(arr):
    minnum = 99999999999999999
    for a_num in arr:
        if minnum > a_num:
            minnum = a_num
    return minnum
  
# alternate version, comparing values within an array 
def min3(arr):
    if len(arr) == 1:
        return arr[0]

    # if more than one element, then initialize the min
    if arr[0] > arr[1]:
        minnum = arr[1]
    else:
        minnum = arr[0]

    for i in range(2, len(arr)):
        if arr[i] < minnum:
            minnum = arr[i]

    return minnum
  
