# iterative factorial
def iter_factorial(n):
    fact = 1
    if n in [0,1]:
        return 1
    elif n > 1:
        while n > 0:
            fact = fact * n
            n = n - 1
        return fact

  
# recursive factorial
def recur_factorial(n):
    # base case
    if n in [0,1]:
        return 1
    # recursive case
    elif n > 1:
        return n * recur_factorial(n-1)
    # invalid
    else:
        return None

      
print(iter_factorial(5))
print(recur_factorial(5))
