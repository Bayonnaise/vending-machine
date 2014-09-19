class CashContainer

	AMOUNTS = { "1p" => 0.01,
							"2p" => 0.02,
							"5p" => 0.05,
							"10p" => 0.10,
							"20p" => 0.20,
							"50p" => 0.50,
							"£1" => 1.00,
							"£2" => 2.00 }

	def initialize
		@coins = {  "1p" => 0,
								"2p" => 0,
								"5p" => 0,
								"10p" => 0,
								"20p" => 0,
								"50p" => 0,
								"£1" => 0,
								"£2" => 0 }
	end

	attr_reader :coins

	def empty?
		coin_count == 0
	end

	def coin_count
		coins.values.inject(&:+)
	end

	def accept_coins(batch)
		coins.merge!(batch) { |coin, existing, extra| existing + extra }
	end

	def release_coins(batch)
		batch.each do |type, quantity|
			if enough?(coins[type], quantity)
				coins[type] -= quantity
			else
				puts "Not enough #{type} coins!"
			end
		end
	end

	def total_value
		total = 0
		coins.each do |type, quantity|
			total += AMOUNTS[type] * quantity
		end
		total
	end

	def quantity(type)
		coins[type]
	end

	private

	def enough?(total, quantity)
		(total -= quantity) >= 0
	end
end