require 'vending_machine'

describe 'vending machine' do
	let(:machine) { VendingMachine.new }

	context 'when initialised' do
		it 'has a coin holder' do
			expect(machine.money).to be_empty
		end

		it 'has an empty product rack' do
			expect(machine.products).to be_empty
		end
	end

	context 'loading the contents' do
		it 'can be loaded with change' do
			machine.fill_with_change("£2" => 10, "£1" => 5, "20p" => 3)
			expect(machine.money.total_value).to eq 25.60
		end
	end
end