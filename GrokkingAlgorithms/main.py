def binary_search(list, item):
    low_index = 0
    high_index = len(list) - 1

    while low_index <= high_index:
        print("\tNew iteration, l, h", low_index, high_index)
        mid = int((low_index + high_index) / 2)  # rounded down by Python automatically if low_index + high_index is uneven
        print("Mid:", int(mid))
        guess = list[int(mid)]
        print("Guessing the number:", guess)
        if guess == item:
            return mid
        if guess > item:
            high_index = int(mid - 1)
            print("High is set to:", high_index)
        else:
            low_index = mid + 1
    return None


my_list = [1, 2, 3, 5, 7, 8, 9]
print(binary_search(my_list, 1))
# print(binary_search(my_list, -1))
