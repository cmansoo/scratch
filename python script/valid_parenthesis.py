# using stacks

def check(str):
    par_dict = {'[':']', '{':'}', '(':')'}
    stack = []
    
    for i in str:
        if i in par_dict.keys():
            stack.append(i)
        else:
            if stack == []:
                return False
            current_par = stack.pop()
            if i != par_dict[current_par]:
                return False
    
    return stack == []
