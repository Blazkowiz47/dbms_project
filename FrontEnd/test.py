import json
file1 = open('countries.txt', 'r')
Lines = file1.readlines()

count = 0
for index, line in enumerate(Lines):
    Lines[index] = line[:len(line)-1]
with open('result.txt', 'w+') as f:
    json.dump(Lines, f)
