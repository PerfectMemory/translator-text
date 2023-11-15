# frozen_string_literal: true

module TranslatorText
  module Types
    class Translation < Dry::Struct
      include Types::JSON

      transform_keys(&:to_sym)

      attribute :text, Types::Strict::String
      attribute :to, Types::Symbol
    end
  end
end
