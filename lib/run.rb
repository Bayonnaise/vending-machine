require_relative './vending_machine.rb'

haribo = Product.new("Haribo", 1.50)
kitkat = Product.new("Kit-Kat", 0.65)
cuddly_toy = Product.new("Cuddly Toy", 6.99)
gun = Product.new("Gun", 16.49)

products = { haribo => 3, kitkat => 1, cuddly_toy => 7, gun => 0 }

starting_coins = { 	"£2" => 10,
										"£1" => 10,
										"50p" => 10,
										"20p" => 15,
										"10p" => 15,
										"5p" => 15,
										"2p" => 20,
										"1p" => 30 }

machine = VendingMachine.new(coins: starting_coins, products: products)

machine.run