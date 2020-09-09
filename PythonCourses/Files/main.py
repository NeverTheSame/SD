# print(os.path.abspath("Test.log"))
# /Users/kirill/Documents/SD/PythonCourses/Test.log
import os
import datetime
import csv


# print(os.getcwd())
# os.mkdir("new_dir")
# os.chdir("new_dir")
# print(os.getcwd())
# os.rmdir("new_dir")


# for name in os.listdir(os.getcwd()):
#     fullname = os.path.join(os.getcwd(), name)
#     if os.path.isdir(fullname):
#         print(f"{fullname} is a directory")
#     else:
#         print(f"{fullname} is a file")


def create_python_script(filename):
    """Creates a new python script in the current working directory, adds the line of comments to it declared by the
     'comments' variable, and returns the size of the new file"""
    comments = "# Start of a new Python program"
    with open(filename, "w") as file:
        filesize = file.write(comments)
    return filesize


def new_directory(directory, filename):
    """Creates a new directory inside the current working directory, then creates a new empty file inside the
    new directory, and returns the list of files in that directory. """
    # Before creating a new directory, check to see if it already exists
    if os.path.isdir(directory) == False:
        os.mkdir(os.path.join(directory))

    # Create the new file inside of the new directory
    os.chdir(directory)
    with open(filename, "w") as file:
        pass

    # Return the list of files in the new directory
    # return os.path.join(directory, filename)
    result = []
    for name in os.listdir(os.getcwd()):
        result.append(name)
    return result


def file_date(filename):
    """Creates a new file in the current working directory, checks the date that the file was modified,
    and returns just the date portion of the timestamp in the format of yyyy-mm-dd"""
    # Create the file in the current directory
    with open(filename, "w"):
        pass
    timestamp = datetime.datetime.now()
    # Return just the date portion
    return "{}".format(str(timestamp)[:10])


def parent_directory():
    """Returns the name of the directory that's located just above the current working directory."""
    # Create a relative path to the parent
    # of the current working directory
    relative_parent = os.path.join(os.getcwd(), "..")

    # Return the absolute path of the parent directory
    os.chdir(relative_parent)
    return os.getcwd()


# f = open("csv_file.txt")
# csv_f = csv.reader(f)
# for row in csv_f:
#     name, phone, role = row
#     print(f"Name: {name}, Phone: {phone}, Role: {role}")
#
# f.close()

# hosts = [["workstation.local", "192.168.25.46"], ["webserver.cloud", "10.2.5.6"]]
# with open("hosts.csv", "w") as hosts_csv:
#     writer = csv.writer(hosts_csv)
#     writer.writerows(hosts)


def print_O365_users_using_DictReader():
    parent_dir = os.path.join(os.getcwd(), "..")
    os.chdir(parent_dir)
    path_to_csv = os.path.join(os.getcwd(), "O365", "O365users.csv")
    with open(path_to_csv) as users:
        reader = csv.DictReader(users)
        for row in reader:
            if row['SMTP']:
                print(f"{row['UserName']} has {row['SMTP']} SMTP.")
            else:
                print(f"{row['UserName']} doesn't have SMTP.")


def create_file(filename):
    """Creates a file with data in it"""
    with open(filename, "w") as file:
        file.write("name,color,type\n")
        file.write("carnation,pink,annual\n")
        file.write("daffodil,yellow,perennial\n")
        file.write("iris,blue,perennial\n")
        file.write("poinsettia,red,perennial\n")
        file.write("sunflower,yellow,annual\n")


def contents_of_file(filename):
    """Reads the file contents and format the information about each row"""
    return_string = ""

    # Call the function to create the file
    create_file(filename)

    # Open the file
    with open(filename, "r") as file:
        reader = csv.DictReader(file)
        for row in reader:
            return_string += "a {} {} is {}\n".format(row["color"], row["name"], row["type"])
    return return_string


# Call the function
print(contents_of_file("flowers.csv"))



