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
end