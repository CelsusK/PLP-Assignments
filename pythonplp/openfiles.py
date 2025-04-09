# Writing to the file
with open('yourfile.txt', 'w') as f:
    f.write("Name: Cassian\n")
    f.write("Course: Software Development\n")

# Reading from the file to confirm the content
with open('yourfile.txt', 'r') as f:
    content = f.read()
print(content)