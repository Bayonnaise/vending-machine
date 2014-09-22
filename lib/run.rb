require_relative './vending_machine.rb'

haribo = Product.new("Haribo", 1.50)
kitkat = Product.new("Kit-Kat", 0.65)

products = { haribo => 3, kitkat => 1 }

starting_coins = { 	"£2" => 10,
										"£1" => 10,
										"50p" => 10,
										"20p" => 15,
										"10p" => 15,
										"5p" => 15,
										"2p" => 20,
										"1p" => 30 }

machine = VendingMachine.new(coins: starting_coins, products: products)

puts machine.inspect
machine.run