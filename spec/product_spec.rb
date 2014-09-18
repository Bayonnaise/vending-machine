require 'product'

describe 'product' do
	let(:product) { Product.new }

	context 'when initialised' do
		it 'has a name' do
			expect(product.name).to eq "Default name"
		end

		it 'has a price' do
			expect(product.price).to eq 0.99
		end
	end

	context 'maintenance' do
		it 'can be given a new name' do
			product.set_name("Aero")
			expect(product.name).to eq "Aero"
		end

		it 'can be given a new price' do
			product.set_price(2.50)
			expect(product.price).to eq 2.50
		end
	end
end