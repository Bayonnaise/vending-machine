require 'vending_machine'

describe 'vending machine' do
	context 'when initialised' do
		let(:machine) { VendingMachine.new }

		it 'has a coin holder' do
			expect(machine.cash).to be_empty
		end

		it 'has an empty product rack' do
			expect(machine.products).to be_empty
		end
	end
end