require 'dry-struct'

module TranslatorText
  # Includes all the types for the exchanges with the API
  module Types
    include Dry.Types

    Symbol = Types::Symbol.constructor do |str|
      str ? str.to_sym : str
    end

    class << self
      def Sentence(item)
        if item.is_a?(Types::Sentence)
          item
        elsif item.is_a?(String)
          Types::Sentence.new(Text: item)
        end
      end
    end

    module JSON
      def to_json(*args)
        to_hash.to_json(*args)
      end
    end
  end
end

require_relative 'types/sentence'
require_relative 'types/translation'
require_relative 'types/translation_result'
require_relative 'types/alternative'
require_relative 'types/detection_result'
