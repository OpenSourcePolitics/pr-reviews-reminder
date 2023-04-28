# frozen_string_literal: true

require 'spec_helper'
require_relative '../src/name_helper'

describe NameHelper do
  let(:github_name) { 'github_name' }
  let(:rocket_name) { 'rocket_name' }
  let(:names_map) { "#{github_name}:#{rocket_name}" }

  describe '.find' do
    it 'returns the name helper' do
      with_modified_env('NAMES_MAP' => names_map) do
        expect(described_class.find(github_name).rocket_name).to eq(rocket_name)
      end
    end

    context 'when the name is not found' do
      it 'returns the name helper' do
        with_modified_env('NAMES_MAP' => names_map) do
          expect(described_class.find('not_found').rocket_name).to eq('not_found')
        end
      end
    end
  end
end
