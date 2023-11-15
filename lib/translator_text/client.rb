# frozen_string_literal: true

require 'json'
require 'securerandom'
require 'httparty'

module TranslatorText
  class Client
    include HTTParty
    format :json

    base_uri 'https://api.cognitive.microsofttranslator.com'
    API_VERSION = '3.0'

    query_string_normalizer proc { |query|
      query.map do |key, value|
        Array(value).map { |v| "#{key}=#{v}" }
      end.join('&')
    }

    # Initialize the client
    # @since 1.0.0
    #
    # @param api_key [String] the Cognitive Services API Key
    def initialize(api_key)
      @api_key = api_key
    end

    # Translate a group of sentences.
    #
    # The following limitations apply:
    # * The array _sentences_ can have at most 25 elements.
    # * The entire text included in the request cannot exceed 5,000 characters including spaces.
    # @see https://docs.microsoft.com/en-us/azure/cognitive-services/translator/reference/v3-0-translate
    #
    # @param sentences [Array<String, TranslatorText::Types::Sentence>] the sentences to process
    # @param to [Symbol] Specifies the language of the output text (required)
    # @param options [Hash] the optional options to transmit to the service. Consult the API documentation for the exhaustive available options.
    # @return [Array<TranslatorText::Types::TranslationResult>] the translation results
    def translate(sentences, to:, **options)
      results = post(
        '/translate',
        body: build_sentences(sentences).to_json,
        query: { to:, **options }
      )

      results.map { |r| Types::TranslationResult.new(r) }
    end

    # Identifies the language of a piece of text.
    #
    # The following limitations apply:
    # * The array _sentences_ can have at most 100 elements.
    # * The text value of an array element cannot exceed 10,000 characters including spaces.
    # * The entire text included in the request cannot exceed 50,000 characters including spaces.
    # @see https://docs.microsoft.com/en-us/azure/cognitive-services/translator/reference/v3-0-detect
    #
    # @param sentences [Array<String, TranslatorText::Types::Sentence>] the sentences to process
    # @return [Array<TranslatorText::Types::DetectionResult>] the detection results
    def detect(sentences)
      results = post(
        '/detect',
        body: build_sentences(sentences).to_json
      )

      results.map { |r| Types::DetectionResult.new(r) }
    end

    private

    def build_sentences(sentences)
      sentences.map do |sentence|
        Types::Sentence(sentence)
      end
    end

    def post(path, params)
      options = {
        headers:,
        query: {}
      }.merge(params)

      options[:query][:'api-version'] = API_VERSION

      response = self.class.post(path, options)
      handle_response(response)
    end

    # Handle the response
    #
    # If success, return the response body
    # If failure, raise an error
    def handle_response(response)
      case response.code
      when 200..299
        response
      else
        if response.request.format == :json
          raise ServiceError.new(
            code: response['error']['code'],
            message: response['error']['message']
          )
        else
          raise NetError.new(
            code: response.code,
            message: response.response.message
          )
        end
      end
    end

    def headers
      {
        'Ocp-Apim-Subscription-Key' => @api_key,
        'X-ClientTraceId' => SecureRandom.uuid,
        'Content-type' => 'application/json'
      }
    end
  end
end
