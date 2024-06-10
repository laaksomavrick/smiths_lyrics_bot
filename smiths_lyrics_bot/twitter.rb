# frozen_string_literal: true

require 'x'

module Twitter
  def self.client(x_credentials = {})
    X::Client.new(**x_credentials)
  end
end
