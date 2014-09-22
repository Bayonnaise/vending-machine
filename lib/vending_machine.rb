require_relative './cash_container.rb'
require_relative './product.rb'

class VendingMachine
	def initialize(coins: coins={}, products: products={})
		@money = CashContainer.new 
		load_coins(coins)
		@products = products
	end

	attr_reader :money, :products

	def load_coins(batch)
		money.accept_coins(batch)
	end

	def load_products(batch)
		products.merge!(batch) { |product, existing, extra| existing + extra }
	end

	def release_coins(batch)
		money.release_coins(batch)
	end

	def release_product(product)
		can_be_released?(product) ? reduce_by_one(product) : (puts "Out of stock")
	end

	def request_order
		display_menu
		check_choice(get_order_number)
	end

	def display_menu
		products.each_with_index { |product, index| display_product(product, index) }
	end

	def process_payment(amount)
		money.request_payment(amount)
		give_change(money.calculate_change(money.inserted_total-amount))
	end

	def run
		loop do 
			puts "-------------------\nWelcome to the vending machine (change remaining: #{price_to_string(money.total_value/100.00)})"
			process_payment(get_price(request_order))
		end
	end

	private

	def try_again
		puts "Out of stock, choose again"
		request_order
	end

	def get_order_number
		puts "-------------------\nEnter a product number, or type q to exit"
		gets.chomp
	end

	def can_be_released?(product)
		is_valid?(product) && is_in_stock?(product)
	end

	def is_valid?(product)
		products.has_key?(product)
	end

	def is_in_stock?(product)
		products[product] > 0
	end

	def reduce_by_one(product)
		products[product] -= 1
	end

	def display_product(product, index)
		puts "#{index+1}. #{product[0].name}, #{price_to_string(product[0].price)} - #{product[1]} in stock"
	end

	def price_to_string(price)
		"£#{sprintf('%.2f', price)}"
	end

	def get_price(order)
		get_product(order).price*100
	end

	def give_change(change)
		release_coins(change)
		show_change(change)
	end

	def show_change(change)
		puts "-------------------\nHere is your change:"
		change.each { |type, quantity| puts "#{type} x #{quantity}" }
	end

	def check_choice(order)
		exit if order == "q"
		product = get_product(order)
		return try_again if !is_in_stock?(product)
		release_product(product)
		order
	end

	def get_product(order)
		products.to_a[order.to_i-1][0]
	end
end