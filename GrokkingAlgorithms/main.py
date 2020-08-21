my_list = [1, 2, 11, 3, 5, 7, 8, 9, 0]


def binary_search(list_of_ints, item):
    """ Method for doing binary search."""
    low_index = 0
    high_index = len(list_of_ints) - 1

    while low_index <= high_index:
        mid = int((low_index + high_index) / 2)  # rounded down by Python automatically if low_index + high_index is uneven
        guess = list_of_ints[int(mid)]
        if guess == item:
            return mid
        if guess > item:
            high_index = int(mid - 1)
        else:
            low_index = mid + 1
    return None


def findSmallest(arr):
    """Find the smallest element in an array"""
    smallest = arr[0]
    smallest_index = 0
    for i in range(1, len(arr)):
        if arr[i] < smallest:
            smallest = arr[i]
            smallest_index = i
    return smallest_index


def selectionSort(arr):
    """Sorts an array"""
    new_arr = []
    for i in range(len(arr)):
        """Finds the smallest element in the array and adds it to the new array"""
        smallest = findSmallest(arr)
        new_arr.append(arr.pop(smallest))
    return new_arr


print(selectionSort(my_list))

