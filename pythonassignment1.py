def calculator(x, y, operation):
    if operation == '+':
        result = x + y
    elif operation == '-':
        result = x - y
    elif operation == '*':
        result = x * y
    elif operation == '/':
        if y == 0:
            return "Division by zero is not allowed"  
        result = x / y
    else:
        return "Invalid operation"  

    
    print(f"{x} {operation} {y} = {result}")
    return result


calculator(23, 7, "+")