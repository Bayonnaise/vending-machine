require_relative './cash_container.rb'
require_relative './product.rb'

class VendingMachine
	def initialize
		@cash = CashContainer.new
		@products = []
	end

	attr_reader :cash, :products
end