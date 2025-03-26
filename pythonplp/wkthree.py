def calculate_discount(price, discount_percent):
    if discount_percent >= 20:
        discount = price * discount_percent / 100
        new_price = price - discount
        return new_price
    else:
        return price
Price = calculate_discount(100, 4) 
print(Price) # 80.0
