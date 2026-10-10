import numpy as np

image = np.array([
    [0,0,0,0,0],
    [0,255,255,255,0],
    [0,255,255,255,0],
    [0,255,255,255,0],
    [0,0,0,0,0],
])

kernel=np.array([
    [1,0,-1],
    [1,0,-1],
    [1,0,-1],
])

output=np.zeros((3,3), dtype=int)

for row in range(3):
 for col in range(3):
    patch=image[row:row+3, col:col+3]
    output[row, col] = np.sum(patch * kernel) 

print(output)