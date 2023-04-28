# frozen_string_literal: true

require 'spec_helper'
require_relative '../src/request_helper'

describe RequestHelper do
  let(:content) do
    {
      'key' => 'value'
    }
  end
  # rubocop:disable RSpec/VerifiedDoubles
  let(:request) { double('request', body: double('body', read: JSON.dump(content))) }
  # rubocop:enable RSpec/VerifiedDoubles

  describe '.search_body_for' do
    it 'returns the value for the given key' do
      expect(described_class.search_body_for(request, 'key')).to eq('value')
    end
  end

  describe '.parse_body' do
    it 'returns the parsed body' do
      expect(described_class.parse_body(request)).to eq('key' => 'value')
    end
  end

  describe '.authorized?' do
    it 'returns false if the token is incorrect' do
      with_modified_env({ 'API_TOKEN' => 'foo' }) do
        expect(described_class).not_to be_authorized(request)
      end
    end

    context 'when the token is correct' do
      let(:content) do
        {
          'token' => 'foo'
        }
      end

      it 'returns true if the token is incorrect' do
        with_modified_env({ 'API_TOKEN' => 'foo' }) do
          expect(described_class).to be_authorized(request)
        end
      end
    end
  end
end
