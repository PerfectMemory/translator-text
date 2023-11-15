# frozen_string_literal: true

require_relative 'translator_text/version'
require_relative 'translator_text/exceptions'
require_relative 'translator_text/client'
require_relative 'translator_text/types'

module TranslatorText
  class << self
    attr_writer :client

    def client
      @client ||= build_client
    end

    private

    def build_client
      TranslatorText::Client.new(ENV.fetch('COGNITIVE_SUBSCRIPTION_KEY'))
    end
  end
end
