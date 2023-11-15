# frozen_string_literal: true

require 'spec_helper'

describe TranslatorText::Client do
  let(:client) do
    described_class.new(
      ENV.fetch('COGNITIVE_SUBSCRIPTION_KEY', 'XXX'),
      ENV.fetch('COGNITIVE_SUBSCRIPTION_REGION', nil)
    )
  end

  describe '(integrations tests)', integration: true do
    before(:all) do
      WebMock.disable!
    end

    after(:all) do
      WebMock.enable!
    end

    describe '#translate' do
      let(:sentences) do
        [
          'First sentence',
          'Second sentence'
        ]
      end

      let(:results) do
        client.translate(
          sentences,
          to: %i[fr es]
        )
      end

      it 'translates succesfully' do
        expect(results.map { |r| r.translations[0].text }).to eq ['Première phrase', 'Deuxième phrase']
      end
    end

    describe '#detect' do
      let(:sentences) do
        [
          'First sentence',
          'Deuxième phrase'
        ]
      end

      let(:results) do
        client.detect(sentences)
      end

      it 'detects succesfully' do
        expect(results.map(&:language)).to eq %i[en fr]
      end
    end
  end

  describe '#translate' do
    let(:results) do
      client.translate(sentences, from: :en, to: :fr)
    end

    let(:sentences) do
      [
        TranslatorText::Types::Sentence.new(Text: 'First sentence'),
        TranslatorText::Types::Sentence.new(Text: 'Second sentence')
      ]
    end

    let(:translate_url) do
      'https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&from=en&to=fr'
    end

    before do
      @stub = stub_request(:post, translate_url).with(
        body: '[{"Text":"First sentence"},{"Text":"Second sentence"}]'
      ).to_return(
        body: load_response('translation_1')
      )
    end

    context 'with strings' do
      let(:sentences) do
        ['First sentence', 'Second sentence']
      end

      it 'calls the service' do
        results
        expect(@stub).to have_been_requested
      end
    end

    context 'with Types::Sentence' do
      it 'calls the service' do
        results
        expect(@stub).to have_been_requested
      end
    end

    it 'returns an array of Types::TranslationResult' do
      results.each do |result|
        expect(result).to be_a(TranslatorText::Types::TranslationResult)
      end
    end

    it 'returns the translated sentences' do
      expect(results.map { |r| r.translations[0].text }).to eq ['Première phrase', 'Deuxième phrase']
    end

    it 'returns the detected language' do
      expect(results.map(&:detected_language)).to eq %i[en en]
    end
  end

  describe '#detect' do
    let(:results) do
      client.detect(sentences)
    end

    let(:sentences) do
      [
        TranslatorText::Types::Sentence.new(Text: 'First sentence'),
        TranslatorText::Types::Sentence.new(Text: 'Second sentence')
      ]
    end

    let(:detect_url) do
      'https://api.cognitive.microsofttranslator.com/detect?api-version=3.0'
    end

    before do
      @stub = stub_request(:post, detect_url).with(
        body: '[{"Text":"First sentence"},{"Text":"Second sentence"}]'
      ).to_return(
        body: load_response('detection_1')
      )
    end

    context 'with strings' do
      let(:sentences) do
        ['First sentence', 'Second sentence']
      end

      it 'calls the service' do
        results
        expect(@stub).to have_been_requested
      end
    end

    context 'with Types::Sentence' do
      it 'calls the service' do
        results
        expect(@stub).to have_been_requested
      end
    end

    it 'returns an array of Types::DetectionResult' do
      results.each do |result|
        expect(result).to be_a(TranslatorText::Types::DetectionResult)
      end
    end

    it 'returns the detected language' do
      expect(results.map(&:language)).to eq %i[en en]
    end
  end
end
