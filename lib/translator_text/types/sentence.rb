# frozen_string_literal: true

module TranslatorText
  module Types
    class Sentence < Dry::Struct
      include Types::JSON

      transform_keys(&:to_sym)

      attribute :Text, Types::Strict::String
    end
  end
end
