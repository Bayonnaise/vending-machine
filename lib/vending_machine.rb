require_relative './cash_container.rb'
require_relative './product.rb'

STARTING_COINS = { 	"£2" => 10,
										"£1" => 10,
										"50p" => 10,
										"20p" => 15,
										"10p" => 15,
										"5p" => 15,
										"2p" => 20,
										"1p" => 30 }

class VendingMachine
	def initialize
		@money = CashContainer.new
		@products = []
	end

	attr_reader :money, :products

	def fill_with_change(batch)
		money.accept_coins(batch)
	end
end