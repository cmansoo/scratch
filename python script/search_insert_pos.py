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
    left_ind = 0
    right_ind = len(nums) - 1

    while left_ind <= right_ind:
        mid_ind = (left_ind + right_ind) // 2
        mid_val = nums[mid_ind]

        if mid_val == target:
            return mid_ind

        elif mid_val < target:
            left_ind = mid_ind + 1

        else:
            right_ind = mid_ind - 1

    return right_ind + 1
