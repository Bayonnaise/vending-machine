class CashContainer

	AMOUNTS = { "1p" => 1,
							"2p" => 2,
							"5p" => 5,
							"10p" => 10,
							"20p" => 20,
							"50p" => 50,
							"£1" => 100,
							"£2" => 200 }

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
		batch.each { |type, quantity|	release(type, quantity) }
	end

	def total_value
		coins.map { |type, quantity| AMOUNTS[type] * quantity }.inject(&:+)
	end

	def process_change(amount)
		remove_change(calculate_change(amount))
	end

	def calculate_change(amount, output={})
		AMOUNTS.reverse_each do |coin_type, coin_value|
			next if amount < coin_value

			if not_enough_of_coin(amount, coin_type, coin_value)
				output.merge!(coin_type => coins[coin_type])
				amount -= coins[coin_type] * coin_value
			else
				output.merge!(coin_type => number_of_coins_in(amount, coin_value))
				amount = remainder(amount, coin_value)
			end
		end
		
		enough_change?(amount, output)
	end

	private

	def enough_left?(total, quantity)
		(total -= quantity) >= 0
	end

	def release(type, quantity)
		enough_left?(coins[type], quantity) ? reduce_total(type, quantity) : (puts "Not enough #{type} coins!")
	end

	def reduce_total(type, quantity)
		coins[type] -= quantity
	end

	def not_enough_of_coin(amount, coin_type, coin_value)
		number_of_coins_in(amount, coin_value) > coins[coin_type]
	end

	def number_of_coins_in(amount, coin_value)
		(amount / coin_value).floor
	end

	def remainder(amount, coin_value)
		amount % coin_value
	end

	def enough_change?(amount, output)
		amount == 0 ? (return output) : (raise "Not enough change")
	end

	def remove_change(change)
		coins.merge!(change) { |coin, existing, to_remove| existing - to_remove }
	end
end