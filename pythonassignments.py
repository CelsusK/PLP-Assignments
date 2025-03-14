def calculator(x, y, operation):
    if operation == '+':
        result = x + y
    elif operation == '-':
        result = x - y
    elif operation == '*':
        result = x * y
    elif operation == '/':
        if y == 0:
            return "Division by zero is not allowed"  # Return error message
        result = x / y
    else:
        return "Invalid operation"  # Handle invalid operations

    # Print and return the result
    print(f"{x} {operation} {y} = {result}")
    return result

# Example usage
calculator(23, 7, "+")