# frozen_string_literal: true

require_relative '../smiths_lyrics_bot/app'
require 'json'
require 'rspec'

describe 'lambda_handler' do
  let(:mock_client) { double('MockClient') }

  before do
    # Mock the Twitter.client method before each example
    allow(Twitter).to receive(:client).and_return(mock_client)
    allow(File).to receive(:readlines).and_return(%W[Foo\n Bar\n])

    allow(mock_client).to receive(:post)
  end

  context 'when called' do
    it 'sends a tweet' do
      lambda_handler(event: {}, context: {})

      expect(Twitter).to have_received(:client)
      expect(mock_client).to have_received(:post).with('tweets', '{"text":"Foo\\nBar\\n"}')
    end
  end
end
