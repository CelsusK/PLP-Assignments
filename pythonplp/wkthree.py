def calculate_discount(price, discount_percent):
    if discount_percent >= 20:
        discount = price * discount_percent / 100
        new_price = price - discount
        return new_price
    else:
        return price
Price = calculate_discount() 
print(Price) 
