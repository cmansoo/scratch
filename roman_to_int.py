def roman_to_int(s):
    '''
    type = str
    
    '''

    romans = {
        'I': 1,
        'V': 5,
        'X': 10,
        'L': 50,
        'C': 100,
        'D': 500,
        'M': 1000,
        'IV': 4,
        'IX': 9,
        'XL': 40,
        'XC': 90,
        'CD': 400,
        'CM': 900
    }
    
    total = 0
    i = 0
    while i < len(s):
        # get the value of symbol s[i]
        s1 = romans[s[i]]

        if i + 1 < len(s):
            # get the value of next symbol
            s2 = romans[s[i+1]]

            if s1 >= s2:
                total = total + s1
                i = i + 1
            else:
                total = total + s2 - s1
                i = i + 2

        else:
            total = total + s1
            i = i + 1
    return total

print(roman_to_int('CD'))
