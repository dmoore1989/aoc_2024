MOVEMENTS = [
    [0,1],
    [1,0],
    [-1,0],
    [0,-1],
    [1,-1],
    [-1,-1],
    [1,1],
    [-1,1]
]

def outside_of_array?(index, length)
    index < 0 || index >= length
end
