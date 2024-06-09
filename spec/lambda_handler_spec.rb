# frozen_string_literal: true

require_relative '../smiths_lyrics_bot/app'
require 'json'

describe 'lambda_handler' do
  context 'when given a valid event' do
    it 'returns hello world' do
      response = lambda_handler(event: {}, context: {})
      message = JSON.parse(response[:body])['message']

      expect(message).to eq('Hello World!')
    end
  end
end
