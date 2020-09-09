import csv
import os

from O365 import Account
credentials = ('8e84e489-cc44-42fa-b26a-948dd6d5cf2e', 'Q4iNtYEbX?wL:SDo1UWeWpVa3Xnep]7.')

account = Account(credentials, auth_flow_type='credentials', tenant_id='shakudo.onmicrosoft.com')
# if account.authenticate():
#    print('Authenticated!')

directory = account.directory()
users_list = []


def parent_directory():
    """Returns the name of the directory that's located just above the current working directory."""
    relative_parent = os.path.join(os.getcwd(), "..")

    # Return the absolute path of the parent directory
    os.chdir(relative_parent)
    return os.getcwd()


# (os.chdir(os.path.join(parent_directory(), "..")))
path_to_csv = os.path.join(os.getcwd(), "O365users.csv")

with open(path_to_csv, "w") as users:
    for user in directory.get_users():
        users_list.append([user, user.mail])
    writer = csv.writer(users)
    writer.writerow(["UserName", "SMTP"])
    writer.writerows(users_list)

