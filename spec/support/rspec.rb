# frozen_string_literal: true

module TranslatorText
  # Helpers for Rspec
  module Rspec
    def load_response(fixture)
      File.read(File.join(File.dirname(__FILE__), '..', 'etc', "#{fixture}.json"))
    end
  end
end
