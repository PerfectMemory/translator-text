# frozen_string_literal: true

require 'spec_helper'

describe TranslatorText::Types do
  describe '#to_json' do
    let(:json) do
      TranslatorText::Types::Sentence.new(Text: 'First sentence').to_json
    end

    it 'returns a valid JSON' do
      expect(JSON.parse(json)).to be_a(Hash)
    end
  end
end
