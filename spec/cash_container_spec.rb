require 'cash_container'

describe 'cash container' do
	let(:cash) { CashContainer.new }

	context 'when initialized' do
		it 'is empty' do
			expect(cash).to be_empty
		end

		it 'has a an area for each coin denomination' do
			expect(cash.coins).to eq "1p" => 0, "2p" => 0, "5p" => 0, "10p" => 0, "20p" => 0, "50p" => 0, "£1" => 0, "£2" => 0
		end
	end

	describe 'handling coins' do
		before(:each) do
			cash.accept_coins("1p" => 5, "5p" => 4, "10p" => 1, "£1" => 2, "£2" => 5)
		end

		it 'can accept coins' do
			expect(cash).not_to be_empty
		end

		it 'can count coins' do
			expect(cash.coin_count).to eq 17
		end

		it 'knows the total value of its coins' do
			expect(cash.total_value).to eq 1235
		end

		it 'can release coins' do
			expect(cash.coin_count).to eq 17
			cash.release_coins("1p" => 2, "5p" => 2, "£2" => 3)
			expect(cash.coin_count).to eq 10
		end
	end

	context 'validations' do
		it 'only releases coins it has' do
			expect(cash).to receive(:puts).with("Not enough 1p coins!")
			cash.release_coins("1p" => 1)
			expect(cash.coin_count).to eq 0
		end
	end

	context 'giving change' do
		before(:each) do
			cash.accept_coins("1p" => 10, "2p" => 10, "5p" => 10, "10p" => 5, "20p" => 5, "50p" => 5, "£1" => 5, "£2" => 10)
		end

		it 'gives the fewest number of coins to meet an amount' do
			expect(cash.calculate_change(1887)).to eq ({ "2p" => 1, "5p" => 1, "10p" => 1, "20p" => 1, "50p" => 1, "£2" => 9 })
		end

		it 'only gives coins it has when calulating change' do
			expect(cash.calculate_change(2263)).to eq ({ "£2" => 10, "£1" => 2, "50p" => 1, "10p" => 1, "2p" => 1, "1p" => 1 })
		end

		it 'removes the change from the coins array if successful' do
			expect(cash.coin_count).to eq 60
			cash.process_change(2263)
			expect(cash.coin_count).to eq 44
		end

		it 'gives an error if not enough change to give' do
			expect { cash.process_change(3563) }.to raise_error "Not enough change"
		end
	end

	context 'taking payment' do
		it 'can request coins until a target is met' do
			allow(cash).to receive(:puts)
			expect(cash).to receive(:gets).exactly(4).times.and_return "£1"
			cash.request_payment(345)
			expect(cash.inserted_total).to eq 400
		end
	end
end