#Object Oriented Programming
#OOP helps us model complex x systemms by treating real-world entities as objects within the program
#Classes(Blueprint),Object(SPecific instance of a class),Attributes(Properties of an object) and Methods(Actions or behaviours that an object can perform)
#Encapsulation: Bundling data and methods that operate on that data within a single unit (class). It restricts direct access to some components, which can prevent the accidental modification of data.
#Inheritance: Mechanism by which one class can inherit the attributes and methods of another class. It promotes code reusability and establishes a relationship between classes.
# class Car:
#     def __init__(self,color,model):
#         self.color = color
#         self.model = model

# myCar = Car("red","Toyota")
# myCar2 = Car("blue","Honda")
# print(myCar.color) #red
# print(myCar2.color) 
# class Vehicle:#Inheritance
#     def __init__(self, make, model, year):
#         self.make = make
#         self.model = model
#         self.year = year
# class Car(Vehicle):#Inheritance
#     def __init__(self, make, model, year,):
#         super().__init__(make, model, year)

class Animal:
    def speak(self):
        return "Sound"
class Dog:
    def speak(self):
        return "Bark"
class Cat:
    def speak(self):
        return "Meow"
for animal in (Dog(), Cat()):
    print(animal.speak()) #Bark Meow        
            