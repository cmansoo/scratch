def longestCommonPrefix(self, strs: List[str]) -> str:
  to_return = ""
  # find the shortest string
  shortest = min(strs, key=len)
  for i in range(len(shortest)):
    if all([x.startswith(shortest[:i+1]) for x in strs]):
      to_return = shortest[:i+1]
    else:
      break
    
    return to_return
