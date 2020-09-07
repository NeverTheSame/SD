import os

import wordcloud as wordcloud


def binary_search(list_of_ints, item):
    """ Method for doing binary search."""
    low_index = 0
    high_index = len(list_of_ints) - 1

    while low_index <= high_index:
        mid = int(
            (low_index + high_index) / 2)  # rounded down by Python automatically if low_index + high_index is uneven
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


def fractional_part(numerator, denominator):
    """Divides the numerator by the denominator, and returns just the fractional part (a number between 0 and 1)"""
    if denominator == 0:
        return 0
    res = numerator / denominator
    if res == 0.0:
        return int(res)
    return res - int(res)


def sum_divisors(n):
    """Returns the sum_of_divisors of all the divisors of a number, without including it"""
    sum_of_divisors = 0
    divisor = 1
    while n > 0 and divisor != n:
        if n % divisor == 0:
            sum_of_divisors = sum_of_divisors + divisor
        divisor = divisor + 1
    return sum_of_divisors


def multiplication_table1(number, max_number, result_max):
    """Prints the results of a number passed to it multiplied by 1 through max_number.
    Will end if the result is bigger that result_max"""
    multiplier = 1
    while multiplier <= max_number:
        result = number * multiplier
        # What is the additional condition to exit out of the loop?
        if result > result_max:
            break
        print(str(number) + "x" + str(multiplier) + "=" + str(result))
        # Increment the variable for the loop
        multiplier += 1


def factorial(n):
    """ Returns factorial_func (product of an integer and all the integers below it)."""
    result = 1
    for i in range(n):
        result = result + (i * result)
    return result


def print_dominoes():
    """Prints all dominoes"""
    number_of_dominoes_incremented = 7
    for left in range(number_of_dominoes_incremented):
        for right in range(left, number_of_dominoes_incremented):
            print("[" + str(left) + "|" + str(right) + "]", end=" ")
        print()


def print_home_vs_away_teams(teams_specified):
    for home_team in teams_specified:
        for away_team in teams_specified:
            if home_team != away_team:
                print(home_team + " vs " + away_team)


teams = ['Dragons', 'Wolves', 'Pandas', 'Unicorns']


def factorial_func(number):
    """Returns factorial of n"""
    result = 1
    for x in range(1, number):
        result = result * x
    return result


def factorial_func_recursive(n):
    """Returns factorial of n"""
    if n < 2:
        return 1
    return n * factorial_func_recursive(n - 1)


def sum_positive_numbers(n):
    """Returns the sum of all positive numbers between the number n received and 1"""
    # The base case is n being smaller than 1
    if n < 1:
        return 0
    # The recursive case is adding this number to the sum of the numbers smaller than this one.
    return n + sum_positive_numbers(n - 1)


"""Recursive function structure:
def recursive_function(parameters):
    if base_case_condition(parameters):
        return base_case_value
    recursive_function(modified_parameters)
"""


def is_power_of(number, base):
    """ Returns true whether the number is a power of the given base. Base is assumed to be a positive number.
    Base case: when number is smaller than base."""
    if number < base:
        # If number is equal to 1, it's a power (base**0).
        return base ** 0 == number

    # Recursive case: keep dividing number by base.
    print(number, base, base ** 0)
    return is_power_of(number - 1, base)


def digits(n):
    """Returns how many digits the number has."""
    count = 0
    if n == 0:
        return 1
    while n > 10:
        count += 1
        n = n / 10
    return count + 1


def multiplication_table(start, stop):
    """Prints out a multiplication table (where each number is the result of multiplying the first number of its row by the number at the top of its column)."""
    for x in range(start, stop + start):
        for y in range(start, stop + start):
            print(str(x * y), end=" ")
        print()


def counter(start, stop):
    """Counts down from start to stop when start is bigger than stop, and counts up from start to stop otherwise."""
    x = start
    if stop > start or stop == start:
        return_string = "Counting up: "
        while x <= stop:
            return_string += str(x)
            if x != stop:
                return_string += ","
            x += 1
    else:
        return_string = "Counting down: "
        while x >= stop:
            return_string += str(x)
            if x != stop:
                return_string += ","
            x -= 1
    return return_string


def even_numbers(maximum):
    """Returns a space-separated string of all positive numbers that are divisible by 2, up to and including the maximum that's passed into the function."""
    return_string = ""
    for x in range(1, maximum + 1):
        if x % 2 == 0:
            return_string += str(x) + " "
    return return_string.strip()


def initials(phrase):
    """Returns the initials of the words contained in the phrase received, in upper case."""
    words = phrase.split()
    result = ""
    for word in words:
        result += word[0].upper()
    return result


def to_celsius(x):
    return (x - 32) * 5 / 9


def print_celsius_formatted_from_0_to_100():
    for x in range(0, 101, 10):
        print("{:>3} F | {:>6.2f} C".format(x, to_celsius(x)))


def is_palindrome(input_string):
    """Checks if a string is a palindrome. A palindrome is a string that can be equally read
    from left to right or right to left,
    omitting blank spaces, and ignoring capitalization"""
    new_string = ""
    reverse_string = ""
    # Traverse through each letter of the input string
    for letter in input_string.upper():
        # Add any non-blank letters to the
        # end of one string, and to the front
        # of the other string.
        if letter != " ":
            new_string += letter
            reverse_string = letter + reverse_string
    # Compare the strings
    if new_string == reverse_string:
        return True
    return False


def replace_ending(sentence, old, new):
    """Replaces the old string in a sentence with the new string, but only if the sentence ends with the old string. """
    if old == sentence.split()[-1]:
        i = len(old)
        new_sentence = sentence[:-i] + new
        return new_sentence
    # Return the original sentence if there is no match
    return sentence


def skip_elements(elements):
    """Returns a list containing every other element from an input list, starting with the first element."""
    new_list = []
    for item in elements:
        if elements.index(item) % 2 == 0:
            new_list.append(item)
    return new_list


def skip_elements(elements):
    result = []
    for index, element in enumerate(elements):
        if index % 2 == 0:
            result.append(element)
    return result


def pig_latin(text):
    """Turns text into pig latin: a simple text transformation that modifies each word moving the first character
    to the end and appending "ay" to the end"""
    result = []
    # Separate the text into words
    words = text.split()
    for word in words:
        result.append(word[1:] + word[0] + "ay")

    return " ".join(result)


def octal_to_string(octal):
    """Converts a permission in octal format into a string format."""
    result = ""
    value_letters = [(4, "r"), (2, "w"), (1, "x")]
    # Iterate over each of the digits in octal
    for digit in [int(n) for n in str(octal)]:
        # Check for each of the permissions values
        for value, letter in value_letters:
            if digit >= value:
                result += letter
                digit -= value
            else:
                result += "-"
    return result


def group_list(group, users):
    """Accepts a group name and a list of members, and returns a string with the format: group_name: member1, member2."""
    members = []
    for member in users:
        members.append(member)
    res = group + ": " + ", ".join(members)
    return res


def guest_list(guests):
    for name, age, profession in guests:
        print(f"{name} is {age} years old and works as {profession}")


def count_letters(text):
    result = {}
    for letter in text:
        if letter not in result:
            result[letter] = 0
        result[letter] += 1
    return result


for root, dirs, files in os.walk("."):
    for filename in files:
        if filename == "Test.log":
            text = filename


def email_list(domains):
    """Receives a dictionary, which contains domain names as keys, and a list of users as values.
    Generates a list that contains complete email addresses (e.g. diana.prince@gmail.com)."""
    emails = []
    for provider, users in domains.items():
        for user in users:
            emails.append(user + "@" + provider)
    return (emails)


def groups_per_user(group_dictionary):
    """Receives a dictionary, which contains group names with the list of users.
    Users can belong to multiple groups.
    Returns a dictionary with the users as keys and a list of their groups as values.
    """
    user_groups = {}
    user_groups_set = set()
    for groups, users in group_dictionary.items():
        user_groups_set.add(groups)
        for user in users:
            user_groups[user] = user_groups_set
    return user_groups


def groups_per_user(group_dictionary):
    """Receives a dictionary, which contains group names with the list of users.
    Users can belong to multiple groups.
    Returns a dictionary with the users as keys and a list of their groups as values.
    """
    user_groups = {}
    for group, users in group_dictionary.items():
        for user in users:
            if user in user_groups:
                user_groups[user].append(group)
            else:
                user_groups[user] = [group]
    return user_groups


def format_address(address_string):
    """Separates out parts of the address string into new strings: house_number and street_name, and returns:
    house number X on street named Y"""
    street_name = ""
    street = []
    for index, item in enumerate(address_string.split(" ")):
        if index == 0:
            house_number = item
        if index != 0:
            street.append(item)
        street_name = " ".join(street)
    return "house number {} on street named {}".format(house_number, street_name)


def highlight_word(sentence, word):
    """Changes the given word in a sentence to its upper-case version.
    For example, highlight_word("Have a nice day", "nice") returns "Have a NICE day"."""
    return sentence[:sentence.index(word)] + word.upper() + sentence[sentence.index(word) + len(word):]


def combine_lists(list1, list2):
    """Combines both lists into one list as follows: the contents of list1, followed by list2 in reverse order"""
    return list1 + list2[::-1]


def squares(start, end):
    """Receives the variables start and end, and returns a list of squares of consecutive numbers between
    start and end inclusively"""
    return [n * n for n in range(start, end + 1)]


def car_listing(car_prices):
    result = ""
    for car, price in car_prices.items():
        result += "{} costs {} dollars".format(car, price) + "\n"
    return result


def combine_guests(guests1, guests2):
    return dict(list(guests1.items()) + list(guests2.items()))


def count_letters(text):
    """Counts the frequency of letters in the input string."""
    result = {}
    for letter in text:
        if letter.isalpha():
            l_letter = letter.lower()
            if l_letter in result.keys():
                result[l_letter] += 1
            else:
                result[l_letter] = 1
    return result


class Furniture:
    color = ""
    material = ""


table = Furniture()
table.color = "brown"
table.material = "wood"

couch = Furniture()
couch.color = "red"
couch.material = "leather"


def describe_furniture(piece):
    return "This piece of furniture is made of {} {}".format(piece.color, piece.material)


class Clothing:
    stock = {'name': [], 'material': [], 'amount': []}

    def __init__(self, name):
        material = ""
        self.name = name

    def add_item(self, name, material, amount):
        Clothing.stock['name'].append(self.name)
        Clothing.stock['material'].append(self.material)
        Clothing.stock['amount'].append(amount)

    def stock_by_material(self, material):
        count = 0
        n = 0
        for item in Clothing.stock['material']:
            if item == material:
                count += Clothing.stock['amount'][n]
                n += 1
        return count


class shirt(Clothing):
    material = "Cotton"


class pants(Clothing):
    material = "Cotton"


polo = shirt("Polo")
sweatpants = pants("Sweatpants")
polo.add_item(polo.name, polo.material, 4)
sweatpants.add_item(sweatpants.name, sweatpants.material, 6)
current_stock = polo.stock_by_material("Cotton")


import random


class Server:
    def __init__(self):
        """Creates a new server instance, with no active connections."""
        self.connections = {}

    def add_connection(self, connection_id):
        """Adds a new connection to this server."""
        connection_load = random.random() * 10 + 1
        # Add the connection to the dictionary with the calculated load
        self.connections[connection_id] = connection_load

    def close_connection(self, connection_id):
        """Closes a connection on this server."""
        # Remove the connection from the dictionary
        del self.connections[connection_id]

    def load(self):
        """Calculates the current load for all connections."""
        total = 0
        # Add up the load for each of the connections
        for connection in self.connections.values():
            total =+ connection
        return total

    def __str__(self):
        """Returns a string with the current load of the server"""
        return "{:.2f}%".format(self.load())


server = Server()
server.add_connection("192.168.1.1")

# print(server)

server.close_connection("192.168.1.1")
# print(server.load())


class LoadBalancing:
    def __init__(self):
        """Initialize the load balancing system with one server"""
        self.connections = {}
        self.servers = [Server()]
        # for i in self.servers:
        #     print(i)
        # print(self.connections)

    def add_connection(self, connection_id):
        """Randomly selects a server and adds a connection to it."""
        server = random.choice(self.servers)
        # Add the connection to the dictionary with the selected server
        self.connections[connection_id] = server
        # Add the connection to the server
        server.add_connection(connection_id)


    def close_connection(self, connection_id):
        """Closes the connection on the the server corresponding to connection_id."""
        # Find out the right server
        # Close the connection on the server
        # Remove the connection from the load balancer

    def avg_load(self):
        """Calculates the average load of all servers"""
        # Sum the load of each server and divide by the amount of servers
        sum = 0
        for load in self.servers:
            sum += load.load()

        return sum

    def ensure_availability(self):
        """If the average load is higher than 50, spin up a new server"""
        pass

    def __str__(self):
        """Returns a string with the load for each server."""
        loads = [str(server) for server in self.servers]
        return "[{}]".format(",".join(loads))


def get_event_date(event):
    return event.date


def current_users(events):
    events.sort(key=get_event_date)

    machines = {}
    for event in events:
        if event.machine not in machines:
            machines[event.machine] = set()
        if event.type == "login":
            machines[event.machine].add(event.user)
        elif event.type == "logout" and event.user in event.machine:
            machines[event.machine].remove(event.user)
    return machines


def generate_report(machines):
    for machine, users in machines.items():
        if len(users) > 0:
            user_list = ", ".join(users)
            print(f"{machine}: {user_list}")


class Event:
    def __init__(self, event_date, event_type, machine_name, user):
        self.date = event_date
        self.type = event_type
        self.machine = machine_name
        self.user = user


events = [
    Event('2020-01-21 12:45:56', 'login', 'myworkstation.local', 'jordan'),
    Event('2020-01-22 15:53:42', 'logout', 'webserver.local', 'jordan'),
    Event('2020-01-21 18:53:21', 'login', 'webserver.local', 'lane'),
    Event('2020-01-22 10:25:34', 'logout', 'myworkstation.local', 'jordan'),
    Event('2020-01-21 08:20:01', 'login', 'webserver.local', 'jordan'),
    Event('2020-01-23 11:24:35', 'logout', 'mailserver.local', 'chris'),
]

users = current_users(events)