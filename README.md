#Vending machine
**Ruby/RSpec technical challenge**

##Objectives

Design a vending machine in code. The vending machine, once a product is selected and the appropriate amount of money is inserted, should return that product.

It should also return change if too much money is provided or ask for more money if there is not enough.

The machine should take an initial load of products and change with denominations 1p, 2p, 5p, 10p, 20p, 50p, £1, £2. There should also be a way of reloading both products and change at a later point.

The machine needs to keep track of the products and money that it contains.

##Development - in progress

####Done...

- Product class contains name and price
- CashContainer class accepts and releases coins, calculates and gives change, gives error if it doesn't have enough change left
- VendingMachine class accepts and releases coins, and accepts and releases products if in stock

####To do...

- Implement interface class, to allow the user to buy products, insert coins and receive change, and to see the current contents of the vending machine.
- Refactor
- Add CodeClimate