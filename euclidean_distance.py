# for n-dimensional points p and q, calculate the distance
def euclidean_distance(p: tuple, q: tuple) -> float:
    distance = 0
    for p_i, q_i in zip(p,q):
        distance = distance + (p_i - q_i)**2

    return distance**0.5


# test
p = (1, 4, 5, 8)
q = (-2, 4, 0, 1)
print(euclidean_distance(p, q))
