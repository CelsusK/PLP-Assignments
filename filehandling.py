try:
  with open("names.txt", "r+") as file:
    Name = file.read()
    print(Name)
    file.write("JoNas")
    print("New name added, Jonas")
except FileNotFoundError:
  print("File not found. Check the filename")

