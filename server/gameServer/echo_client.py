# https://realpython.com/python-sockets/

# echo-client.py

import socket

HOST = "localhost"  # The server's hostname or IP address
PORT = 8080  # The port used by the server

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.connect((HOST, PORT))
    data = input("data:")
    s.sendall(data.encode())
    data = s.recv(1024)

print(f"Received {str(data.decode())}")
