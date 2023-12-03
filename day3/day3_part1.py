#!/usr/bin/env python3

import re # Import regex

# Calls everything
def main():
    file_input = get_input() # Get file input
    total = 0
    # Build multidimensional array with file input
    for i, line in enumerate(file_input):
        file_input[i] = list(line)
    # print(file_input)
    part_numbers = get_part_numbers(file_input)
    # print(part_numbers)
    for part_number in part_numbers:
        # print(part_number)
        total += int(part_number)
    print(f'The sum of the part number is {total}')

# Gets file input
def get_input():
    with open('input.txt') as f:
        lines = f.readlines()
        return lines
    
def get_part_numbers(file_input):
    part_numbers = list()
    for i, line in enumerate(file_input):
        # print(f'i is {i}')
        for j, char in enumerate(line):
            # print(f'j is {j}')
            if re.search("[^a-zA-Z\d\.\n]", char):
                for x in range(-1, 2):
                    # print(f'x is {x}')
                    for y in range(-1, 2):
                        # print(f'y is {y}')
                        if (x == 0 and y == 0):
                            # print("skipping")
                            continue
                        elif i+x > -1 and j+y > -1 and i+x < len(file_input) and j+y < len(file_input[i+x]) and re.search("[\d]", file_input[i+x][j+y]):
                            # part_number = re.sub("[^\d]", '', ''.join(map(str,file_input[i+x][j+y-2:j+y+3])))
                            part_number = file_input[i+x][j+y]
                            file_input[i+x][j+y] = '.'
                            if re.search("\d", file_input[i+x][j+y-1]):
                                part_number = file_input[i+x][j+y-1] + part_number
                                file_input[i+x][j+y-1] = '.'
                                if re.search("\d", file_input[i+x][j+y-2]):
                                   part_number = file_input[i+x][j+y-2] + part_number
                                   file_input[i+x][j+y-2] = '.'
                            if re.search("\d", file_input[i+x][j+y+1]):
                                part_number = part_number + file_input[i+x][j+y+1]
                                file_input[i+x][j+y+1] = '.'
                                if re.search("\d", file_input[i+x][j+y+2]):
                                   part_number = part_number + file_input[i+x][j+y+2]
                                   file_input[i+x][j+y+2] = '.'
                            part_numbers.append(part_number)
                            # print(f'The part number found is {part_number} for char {char}')
                            
    return part_numbers

main()