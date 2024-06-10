# frozen_string_literal: true

module Tweet
  def self.get_tweet_from_lyrics(lyrics = [])
    stanzas = get_lyric_stanzas(lyrics)
    tweetable_stanzas = get_tweetable_stanzas(stanzas)
    tweetable_stanzas.sample
  end

  def self.get_lyric_stanzas(lyrics = [])
    lyrics.each_with_object([[]]) do |line, blocks|
      if line == "\n"
        blocks << []
      else
        fmt = line.downcase.capitalize
        blocks.last << fmt
      end
    end
  end

  def self.get_tweetable_stanzas(lyrics = [])
    lyrics.map do |block|
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
  end
end
