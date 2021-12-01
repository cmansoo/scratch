# newton's mehtod
# root = 0.5 * (X+(N/X)) where X is any guess and N is the number you want to find the sqrt of

# x = number
# loop
# check the diff between the assumed x and calculated root, if not yet insde the tolerance keep going
# if the root comes inside the tolerance then break out of the loop


def sq_rt(n):
    tol = 0.0000001
    x = n
    while True:
        root = 0.5 * (x + (n / x))
        
        if (abs(root-x) < tol):
            return root
        
        x=root

    
print(sq_rt(16))
