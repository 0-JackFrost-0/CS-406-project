import sys
import subprocess
from sha1 import sha1sum
import bcrypt
from server import *
import getpass
import os 

server_path = "database/server.db"
if(not os.path.exists(server_path)):
    os.system("mkdir database")
    create_table(server_path)

def main():
    # username = "alice"
    username = authenticate()
    changes = os.listdir("./")
    # print(sys.argv[1])
    for change in changes:
        if change != ".repo" and change != ".git" and change != ".DS_Store" and change != "__pycache__" and change != "commit.py" and change != "commit.sh" and change != "blob.sh" and change != "tree.sh" and change != "README.md" and change != "database":
            # print(change)
            if os.path.isdir(change):
                # print(change)
                os.system(f"./tree.sh {change} '/Users/omgodage/Desktop/College/vcs-project/vcs' >> .repo/top")
            elif os.path.isfile(change):
                os.system(f"./blob.sh {change} >> .repo/top")
    # print(changes)

    os.system("./commit.sh " + username)
    os.system("rm .repo/top")
    os.system("> .repo/index.i")

def login():
    # print("Enter username: ")
    username = input("Enter username: ")
    # print("Enter password: ")
    # password = input("Enter password: ")
    password = getpass.getpass()
    if(check_user(username, password)):
        print("Successfully authenticated")
    else:
        print("Wrong username or password")
        authenticate()

def authenticate():
    choice = input("1. Login\n2. Sign up\nEnter your choice: ")
    if choice == "1":
        login()
    elif choice == "2":
        # print("Enter username: ")
        username = input("Enter username: ")
        # print("Enter password: ")
        # password = input("Enter password: ")
        password = getpass.getpass()
        if(register_user(username, password)):
            print("Successfully registered")
            os.system("./genkeys.sh " + username)
            return username
        else:
            print("Failed to register")
            authenticate()
    else:
        print("Wrong choice")
        authenticate()

def check_user(username, password):
    password = password.encode('utf-8')
    # Adding the salt to password
    salt = get_salt(username, server_path)
    # Hashing the password
    hashed = bcrypt.hashpw(password, salt)
    state = check_login_info(username, hashed, server_path)
    if(state):
        return True
    else:
        return False

def register_user(username, password):
    password = password.encode('utf-8')
    # Adding the salt to password
    salt = bcrypt.gensalt()
    # Hashing the password
    hashed = bcrypt.hashpw(password, salt)
    state = store_new_info(username, hashed, salt, server_path)
    if(state):
        return True
    else:
        return False

if __name__ == '__main__':
    main()
