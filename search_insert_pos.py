# time complexity O(n)
def searchInsert(nums: List[int], target: int) -> int:
    if target in nums:
        return nums.index(target)
    else:
        for index, value in enumerate(nums):
            if target < value:
                return index
        if target > nums[len(nums)-1]:
            return len(nums)
         
# time complexity O(log n)
# using binary search
def searchInsert2(nums, target):
  pass
