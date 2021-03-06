require 'spec_helper'

RSpec.describe 'Bitrue integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'bitrue' }
  let(:neo_btc_pair) do
    Cryptoexchange::Models::MarketPair.new(base: 'NEO', target: 'BTC', market: market)
  end

  it 'fetch pairs' do
    pairs = client.pairs(market)
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bitrue'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: neo_btc_pair.base, target: neo_btc_pair.target
    expect(trade_page_url).to eq "https://www.bitrue.com/trading?market=btc&symbol=neobtc"
  end

  it 'fetch ticker' do
    ticker = client.ticker(neo_btc_pair)

    expect(ticker.base).to eq 'NEO'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq market
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
