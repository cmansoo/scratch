# remove duplicated elements in a sorted array (leet code problem)
# return the length of the processed arrays

# using set
def removeDuplicates1(nums: list[int]) -> int:
    new_nums = list(set(nums))
    return len(new_nums)

# using del statement
def removeDuplicates2(nums: list[int]) -> int:
    i = 0
    while i < len(nums) - 1:
        if nums[i] == nums[i+1]:
            del nums[i]
        else:
            i += 1
    
    return len(nums)

# test
nums = [0, 0, 1, 1, 1, 2, 2, 3]
assert removeDuplicates1(nums) == removeDuplicates2(nums), "Function outputs are different"
