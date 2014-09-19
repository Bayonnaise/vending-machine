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
			expect(cash.total_value).to eq 12.35
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
end