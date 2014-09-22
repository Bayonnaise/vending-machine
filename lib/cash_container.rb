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
		@change = {}
	end

	attr_reader :coins, :change

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

	def calculate_change(amount_left)
		@change = {}

		AMOUNTS.reverse_each do |coin_type, coin_value|
			next if amount_left < coin_value
			amount_left = process_coin(amount_left, coin_type, coin_value)
		end
		
		enough_change?(amount_left)
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

	def process_coin(amount, type, value)
		return all_of_coin(amount, type) if not_enough_of_coin(amount, type, value)
		
		add_change(type => number_of_coins_in(amount, value))
		remainder(amount, value)
	end

	def not_enough_of_coin(amount, coin_type, coin_value)
		number_of_coins_in(amount, coin_value) > coins[coin_type]
	end

	def all_of_coin(amount, type)
		add_change(type => coins[type])
		amount -= value_of_coins(type)
	end

	def add_change(calculation)
		change.merge!(calculation)
	end

	def number_of_coins_in(amount, coin_value)
		(amount / coin_value).floor
	end

	def value_of_coins(coin_type)
		coins[coin_type] * AMOUNTS[coin_type]
	end

	def remainder(amount, coin_value)
		amount % coin_value
	end

	def enough_change?(amount)
		amount == 0 ? (return change) : (raise "Not enough change")
	end

	def remove_change(change)
		coins.merge!(change) { |coin, existing, to_remove| existing - to_remove }
	end
end