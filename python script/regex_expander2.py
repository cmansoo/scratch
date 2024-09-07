import re
import itertools
import warnings

# # globals
# letters = "abcdefghijklmnopqrstuvwxyz"
# ALPHA_NUMS = letters.upper() + letters + "0123456789"

# # given regex
# # rex = "^W3812$|^405[0-3L-O]$|^N17[04][9FK][0-3]Z$"
# # rex = "^N17[04][9FK][0-3]Z$"
# rex = "02[W04]F[0-4][JK]Z"
# # rex = "^405[0-3L-O]$"
# # rex = "^W3812$"
# verbose = True

# ####### handle single expression
# # extract ranges
# range_patterns = re.findall(r"\[.*?\]", rex)

# # if there is only one range
# if len(range_patterns) == 1:
#     range_pattern = range_patterns[0]
#     # expand range
#     expanded_range = re.findall(range_pattern, ALPHA_NUMS)
#     # replace the original string with each value in the expanded range
    
#     replaced = [rex.replace(range_pattern, x) for x in expanded_range]

#     if verbose: 
#         print("original string:", rex)
#         print("expanded range\treplaced string")
#         for e, r in zip(expanded_range, replaced):
#             print(e.rjust(len("expanded range")), r.rjust(len("replaced string")), sep="\t")

# # else if there is more than one in a sequence
# elif len(range_patterns) > 1:
#     # expand range
#     expanded_range = [re.findall(rng, ALPHA_NUMS) for rng in range_patterns]
#     # range_dict = {}
#     # range_dict = {k: v for k, v in zip(range_patterns, expanded_range)}
#     expanded_range_prod = list(itertools.product(*expanded_range))
    
    
#     # replace?
#     replaced = []

#     for tup in expanded_range_prod:

#         range_dict = {k: v for k, v in zip(range_patterns, tup)}

#         # replace
#         # print(range_dict)

#         rex_copy = rex
        
#         # print("original string: ", rex)
        
#         for k, v in range_dict.items():
#             rex_copy = rex_copy.replace(k, v)
#             # print(rex_copy)

#         # print("final string: ", rex_copy)
        
#         replaced.append(rex_copy)
    
#     # print(replaced)

#     # expanded_range = [x + y + z for x in expanded_range[0] for y in expanded_range[1] for z in expanded_range[2]]
#     # expanded_range = list(itertools.product(*expanded_range))
#     # expanded_range = ["".join(exp_rng) for exp_rng in itertools.product(*expanded_range)]
#     # replace the original string with each value in the expanded range
#     # range_pattern = "".join(range_patterns)
#     # replaced = [rex.replace(range_pattern, x) for x in expanded_range]

#     expanded_range = ["".join(exp_rng) for exp_rng in expanded_range_prod]
#     if verbose: 
#         print("original string:", rex)
#         # print("range patterns: ", range_patterns)
        
#         # print("expanded range product: ", expanded_range_prod)
#         print("expanded range\treplaced string")
#         for e, r in zip(expanded_range, replaced):
#             print(e.rjust(len("expanded range")), r.rjust(len("replaced string")), sep="\t")
    


# # there is no match
# else:
#     # return original string
#     # result = rex
#     print(range_patterns)
#     print(len(range_patterns))







##### functionalize #######

def regex_expander(rex, verbose=True):
    """
    Given a regex with ranges (e.g. "as[1-9]df"), returns a list of strings that expands the bracket and explicitly spells out each match.

    args:
        - rex: regular expression with a range to expand
        - verbose: if True, will print verbose output
    """
    
    alphabets = "abcdefghijklmnopqrstuvwxyz"
    ALPHA_NUMS = alphabets.upper() + alphabets + "0123456789"

    # extract ranges
    range_patterns = re.findall(r"\[.*?\]", rex)

    # replace ranges
    if len(range_patterns) == 1:
        range_pattern = range_patterns[0]
        expanded_range = re.findall(range_pattern, ALPHA_NUMS)
        replaced = [rex.replace(range_pattern, x) for x in expanded_range]

    elif len(range_patterns) > 1:
        expanded_range = [re.findall(rng, ALPHA_NUMS) for rng in range_patterns]
        expanded_range_prod = list(itertools.product(*expanded_range))
        
        replaced = []
        for tup in expanded_range_prod:
            range_dict = {k: v for k, v in zip(range_patterns, tup)}
            
            rex_copy = rex
            for k, v in range_dict.items():
                rex_copy = rex_copy.replace(k, v)
            replaced.append(rex_copy)
        
        # for verbose output
        expanded_range = ["".join(tup) for tup in expanded_range_prod]

    else: 
        replaced = rex
        warnings.warn(f"The input expression {rex} does not contain any ranges.")

        return replaced

    if verbose: # & (expanded_range is not None): 
        print("original string:", rex)
        print("expanded range\treplaced string")
        for e, r in zip(expanded_range, replaced):
            print(e.rjust(len("expanded range")), r.rjust(len("replaced string")), sep="\t")
    
    return replaced
        

# test
# given regex
# rex = "^N17[04][9FK][0-3]Z$"
# rex = "^405[0-3L-O]$"
# r = "02[W04]F[0-4][JK]Z"
# r = "^W3812$"
r = "^W3812$|^405[0-3L-O]$|^N17[04][9FK][0-3]Z$"
# print(regex_expander(r))
def regex_expander_sep(rex, verbose=True):
    rex_split = rex.split("|")
    
    if len(rex_split) == 1:
        return(regex_expander(rex, verbose))
    
    else:
        result = {r: regex_expander(r, verbose) for r in rex_split}
        return result

# print(regex_expander_sep(rex=r, verbose=False))







##### combine under one name? #####
def regex_expander2(rex, verbose=True):
    """
    Given a regex with ranges (e.g. "as[1-9]df"), returns a list of strings that expands the bracket and explicitly spells out each match.
    If input regex contains multiple ranges separated by "|", returns a dictionary of converted strings where the keys are input expressions.

    args:
        - rex: regular expression with a range to expand
        - verbose: if True, will print verbose output
    """
    alphabets = "abcdefghijklmnopqrstuvwxyz"
    ALPHA_NUMS = alphabets.upper() + alphabets + "0123456789"

    def single_expander(rex, verbose):
        # extract ranges
        range_patterns = re.findall(r"\[.*?\]", rex)

        # replace ranges
        if len(range_patterns) == 1:
            range_pattern = range_patterns[0]
            expanded_range = re.findall(range_pattern, ALPHA_NUMS)
            replaced = [rex.replace(range_pattern, x) for x in expanded_range]

        elif len(range_patterns) > 1:
            expanded_range = [re.findall(rng, ALPHA_NUMS) for rng in range_patterns]
            expanded_range_prod = list(itertools.product(*expanded_range))
            
            replaced = []
            for tup in expanded_range_prod:
                range_dict = {k: v for k, v in zip(range_patterns, tup)}
                
                rex_copy = rex
                for k, v in range_dict.items():
                    rex_copy = rex_copy.replace(k, v)
                replaced.append(rex_copy)
            
            # for verbose output
            expanded_range = ["".join(tup) for tup in expanded_range_prod]

        else: 
            replaced = rex
            warnings.warn(f"The input expression {rex} does not contain any ranges.")

            return replaced

        if verbose: 
            print("original string:", rex)
            print("expanded range\treplaced string")
            for e, r in zip(expanded_range, replaced):
                print(e.rjust(len("expanded range")), r.rjust(len("replaced string")), sep="\t")
        
        return replaced
    

    ###
    rex_split = rex.split("|")
    
    if len(rex_split) == 1:
        return single_expander(rex, verbose)
    
    else:
        result = {r: single_expander(r, verbose) for r in rex_split}
        return result

# test
# given regex
# r = "^N17[04][9FK][0-3]Z$"
# r = "^405[0-3L-O]$"
# r = "02[W04]F[0-4][JK]Z"
# r = "^W3812$"
r = "^W3812$|^405[0-3L-O]$|^N17[04][9FK][0-3]Z$"
# print(regex_expander2(r, verbose=False))
print(regex_expander2(r, verbose=True))
