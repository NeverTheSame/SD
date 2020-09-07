def binary_search(custom_list, number):
    if number not in my_list:
        return "Number is not in the list_of_ints!"
    low = 0
    upper = len(custom_list) - 1
    found = False

    while found is False:
        index = int((upper + low) / 2)
        guess = custom_list[index]
        print("I guess the number is", guess)
        if guess is number:
            print("Correct!")
            return f"Position of the number is {index}"
        elif guess < number:
            print("No, the number is bigger\n")
            low = index + 1
        elif guess > number:
            print("No, the number is smaller\n")
            upper = index


my_list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

print(binary_search(my_list, 2))
