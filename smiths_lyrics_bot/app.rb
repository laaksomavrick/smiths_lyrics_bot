# frozen_string_literal: true

require 'json'
require 'x'

# construct a twitter client (dep on nothing)
# read a file (dep on file)
# get the tweet (dep on file)
# tweet the tweet (dep on twitter client)

def twitter_client(api_key:, api_key_secret:, access_token:, access_token_secret:)
  x_credentials = {
    api_key:,
    api_key_secret:,
    access_token:,
    access_token_secret:
  }
  X::Client.new(**x_credentials)
end

def lyrics(lines)
  lyric_blocks = lines.each_with_object([[]]) do |line, blocks|
    if line == "\n"
      blocks << []
    else
      fmt = line.downcase.capitalize
      blocks.last << fmt
    end
  end

  lyric_blocks.map! do |block|
    combined = block.join
    if combined.length > 280
      last_newline = combined[0...280].rindex("\n")
      if last_newline
        combined[0...last_newline]
      else
        combined[0...280]
      end
    else
      combined
    end
  end

  lyric_blocks
end

def sample_lyric(lyrics)
  lyrics.sample
end

def lambda_handler(event:, context:)
  {
    statusCode: 200,
    body: {
      message: 'Hello World!'
      # location: response.body
    }.to_json
  }
end

lines = File.readlines('lyrics.txt')
stanzas = lyrics(lines)
tweet = stanzas.sample

p tweet
