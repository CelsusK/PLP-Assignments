try:
  with open("yourfile.txt", "r+") as file:
    Name = file.read()
    print(Name)
    file.write("\nJoNas")
    print("New name added, Jonas")
except FileNotFoundError:
  print("File not found.Check the filename")

  