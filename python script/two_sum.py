# given an array of integers nums, and and integer target, return indices of the two numbers such that they add up to target.

def two_sum(nums, target):
    for i in range(len(nums)):
        for j in range(i+1, len(nums)):
            if nums[i] + nums[j] == target:
                return i,j


# test
arr = [2,15,11,7]
target = 9

print(two_sum(arr, target))
