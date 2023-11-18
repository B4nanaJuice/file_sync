import subprocess

user_input = input("Give a command: ")

while user_input != "quit" and user_input != "exit":
    print(f"you entered {user_input}")
    subprocess.run(["./fsync.sh", f"{user_input}"])
    user_input = input("Give a command: ")

print("bye !")