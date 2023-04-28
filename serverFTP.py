# code to send and receive files to and from clients using socket programming

# Path: vcs/serverFTP.py
import socket
import os
# from aes import AESEncryptor
import subprocess
import sys

# ncryptr = AESEncryptor(os.urandom(16))

def recvfile(sock, filename):
    key = subprocess.check_output(["./shared_keygen.sh", sys.argv[3], sys.argv[4]])
    key = key.decode()
    key = key.strip()
    f = open(filename, 'wb')
    while True:
        data = sock.recv(1024)
        if not data:
            break
        f.write(data)
    f.close()
    decryptfile = subprocess.check_output(["./ec_decrypt.sh", key, filename])
    os.system("rm " + filename)
    os.system("mv " + decryptfile.decode().strip() + " " + filename)
    print("Successfully get the file")
    sock.close()
    print("Connection closed")

def sendfile(sock, filename):
    key = subprocess.check_output(["./shared_keygen.sh", sys.argv[3], sys.argv[4]])
    key = key.decode()
    key = key.strip()
    # print(len(key[:32]))
    cipherfile = subprocess.check_output(["./ec_encrypt.sh", key, filename])
    f = open(cipherfile.decode().strip(), 'rb')
    while True:
        data = f.read(1024)
        if not data:
            break
        sock.send(data)
    f.close()
    os.system("rm " + cipherfile.decode().strip())
    print("Successfully sent the file")
    sock.close()
    print("Connection closed")

def main():
    # Create a TCP/IP socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR,1)
    # Bind the socket to the port
    # server_address = ('localhost', 10000)
    server_address = ('localhost', 10000)
    print(f"starting up on {server_address}")
    sock.bind(server_address)

    # Listen for incoming connections
    sock.listen(1)

    print("waiting for a connection")
    connection, client_address = sock.accept()

    # try:
    print(f"connection from {client_address}")

    if sys.argv[1] == 'send':
        sendfile(connection, sys.argv[2])
    elif sys.argv[1] == 'recv':
        recvfile(connection, sys.argv[2])

    connection.close()

if __name__ == '__main__':
    main()
