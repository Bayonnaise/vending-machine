#Vending machine [![Code Climate](https://codeclimate.com/github/Bayonnaise/vending-machine/badges/gpa.svg)](https://codeclimate.com/github/Bayonnaise/vending-machine) [![Test Coverage](https://codeclimate.com/github/Bayonnaise/vending-machine/badges/coverage.svg)](https://codeclimate.com/github/Bayonnaise/vending-machine)
**Ruby/RSpec technical challenge**

##Objectives

Design a vending machine in code. The vending machine, once a product is selected and the appropriate amount of money is inserted, should return that product.

It should also return change if too much money is provided or ask for more money if there is not enough.

The machine should take an initial load of products and change with denominations 1p, 2p, 5p, 10p, 20p, 50p, £1, £2. There should also be a way of reloading both products and change at a later point.

The machine needs to keep track of the products and money that it contains.

##Development

The program has three classes: **Product**, **CashContainer** and **VendingMachine**.

The **Product** class tracks each product's name and price. The **CashContainer** class tracks all the money inside the machine, accepts and releases batches of coins, and calculates the change to deliver back to the user. The **VendingMachine** class handles the loading and unloading of coins and products, and the processing of orders using a simple terminal input system.

The system can currently check whether the selected product is in stock, it can check whether it has enough change to give back to the user, and it can give back the change in the coins it has. The ability to reload the machine is in place, but is not presented to the customer through the menu I've implemented. With more time I'd add options to the menu to allow for maintenance, perhaps protected by a password.

---

####How to run

```shell
git clone https://github.com/Bayonnaise/vending-machine.git
cd vending-machine
ruby lib/run.rb
```

####How to test

```shell
git clone https://github.com/Bayonnaise/vending-machine.git
cd vending-machine
rspec
```