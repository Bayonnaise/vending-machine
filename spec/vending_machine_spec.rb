require 'vending_machine'

describe 'vending machine' do
	let(:machine) { VendingMachine.new }
	let(:haribo) { double :product, price: 1.99, name: "Haribo" }
	let(:kitkat) { double :product, price: 0.50, name: "Kit-Kat" }
	let(:products) { { haribo => 3, kitkat => 1 } }
	let(:starting_coins) { { 	"£2" => 10,
														"£1" => 10,
														"50p" => 10,
														"20p" => 15,
														"10p" => 15,
														"5p" => 15,
														"2p" => 20,
														"1p" => 30 } }

	context 'when initialised' do
		it 'has a coin holder' do
			expect(machine.money).to be_empty
		end

		it 'has an empty product rack' do
			expect(machine.products).to be_empty
		end

		it 'can be initialized with coins' do
			machine = VendingMachine.new(coins: starting_coins)
			expect(machine.money.coin_count).to eq 125
		end

		it 'can be initialized with products' do
			machine = VendingMachine.new(products: products)
			expect(machine.products).to eq products
		end
	end

	context 'loading the contents' do
		it 'can be loaded with change' do
			machine.load_coins("£2" => 5, "£1" => 5, "20p" => 3)
			expect(machine.money.total_value).to eq 1560
		end

		it 'can be loaded with products' do
			machine.load_products(products)
			expect(machine.products).to eq products
		end
	end

	context 'releasing the contents' do
		let(:machine) { VendingMachine.new(coins: starting_coins, products: products) }
		
		it 'can give change' do
			expect(machine.money.total_value).to eq 4095
			machine.release_coins("£2" => 2, "50p" => 2, "5p" => 5)
			expect(machine.money.total_value).to eq 3570
		end

		it 'can release a product' do
			machine.release_product(haribo)
			expect(machine.products).to eq haribo => 2, kitkat => 1
		end

		it 'cannot release a product it does not have' do
			wine_gums = double :product
			expect(machine).to receive(:puts).with("Out of stock")
			machine.release_product(wine_gums)
		end
	end

	context 'displaying menu and taking orders' do
		let(:machine) { VendingMachine.new(coins: starting_coins, products: products) }

		it 'displays the menu with prices and quantities' do
			expect(machine).to receive(:puts).with("1. Haribo, £1.99 - 3 in stock")
			expect(machine).to receive(:puts).with("2. Kit-Kat, £0.50 - 1 in stock")
			machine.display_menu
		end

		it 'asks for a choice of product' do
			allow(machine).to receive(:puts)
			expect(machine).to receive(:puts).with("Enter a product number, or type q to exit")
			expect(machine).to receive(:gets).and_return("1")
			machine.request_order
		end

		it 'asks for payment' do
			expect(machine.money).to receive(:request_coin).exactly(2).times.and_return(50)
			machine.process_payment(85)
			expect(machine.money.inserted_total).to eq 100
		end
	end
end