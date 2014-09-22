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
		get_order_number
	end

	def display_menu
		products.each_with_index { |product, index| display_product(product, index) }
	end

	def get_order_number
		puts "Enter a number to choose your product"
		gets.chomp
	end

	def request_payment(amount)
		money.request_payment(amount)
	end

	def run
		order = request_order
		request_payment(get_price(order))
		puts "Thank you"
	end

	private

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
		products.to_a[order.to_i-1][0].price*100
	end
end