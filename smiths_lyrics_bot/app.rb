# frozen_string_literal: true

require 'json'
require 'logger'
require_relative 'tweet'
require_relative 'twitter'

def lambda_handler(event:, context:)
  logger = Logger.new($stdout)
  logger.level = Logger::INFO

  api_key = ENV.fetch('API_KEY', nil)
  api_key_secret = ENV.fetch('API_KEY_SECRET', nil)
  bearer_token = ENV.fetch('BEARER_TOKEN', nil)
  access_token = ENV.fetch('ACCESS_TOKEN', nil)
  access_token_secret = ENV.fetch('ACCESS_TOKEN_SECRET', nil)

  credentials = {
    api_key:,
    api_key_secret:,
    access_token:,
    access_token_secret:,
    bearer_token:
  }

  logger.info('Starting smiths lyrics bot')

  client = Twitter.client(credentials)
  lyrics_file = File.readlines('lyrics.txt')

  tweet = Tweet.get_tweet_from_lyrics(lyrics_file)

  logger.info("Found tweet #{tweet}")

  payload = { text: tweet }.to_json
  response = client.post('tweets', payload)

  logger.info("Successfully tweeted #{response}")

  {
    statusCode: 200
  }
end
