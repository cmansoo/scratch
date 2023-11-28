# An integer is a palindrome when it reads the same backward as forward.

def is_palindrome(x: int) -> bool:
    string_x = str(x)
    reverse_x = ''

    for char in string_x:
        reverse_x = char + reverse_x

    if string_x == reverse_x:
        return True
    else:
        return False

# tests
def test_is_palinedrome_1():
    assert is_palindrome(121)


def test_is_palinedrome_2():
    assert is_palindrome(12341234)

def test_is_palinedrome_3():
    assert is_palindrome(1234321)
