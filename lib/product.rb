class Product
	def initialize(name="Default name", price=0.99)
		@name = name
		@price = price
	end

	attr_accessor :name, :price

	def set_name(new_name)
		@name = new_name
	end

	def set_price(new_price)
		@price = new_price
	end
end