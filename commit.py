import sys
import subprocess
from sha1 import sha1sum
import bcrypt
from server import *
import getpass
import os 

ignore_files = [".DS_Store", ".git", ".repo", "commit.py", "commit.sh", "blob.sh", "tree.sh", "README.md", "database", "__pycache__", "genkeys.sh", "shared_keygen.sh", "ec_encrypt.sh", "ec_decrypt.sh", "aes.py", "sha1.py", "server.py", "clientFTP.py", "serverFTP.py", "init.sh", "sign_verify.sh", "priv_keys", "add.sh"]
# print(len(ignore_files))
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
        # print(change)
        # if change != ".repo" and change != ".git" and change != ".DS_Store" and change != "__pycache__" and change != "commit.py" and change != "commit.sh" and change != "blob.sh" and change != "tree.sh" and change != "README.md" and change != "database":
        if change not in ignore_files:
            # print(change)
            if os.path.isdir(change):
                # print(change)
                os.system(f"./tree.sh {change} '/Users/omgodage/Desktop/CS-406-project-main' >> .repo/top")
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
        return [True, username]
    else:
        print("Wrong username or password")
        # authenticate()
        return [False, username]

def authenticate():
    while(True):
        choice = input("1. Login\n2. Sign up\nEnter your choice: ")
        if choice == "1":
            val, username = login()
            # print(val)
            if(val):
                return username
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
        else:
            print("Wrong choice")

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
