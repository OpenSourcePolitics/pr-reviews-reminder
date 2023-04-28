# frozen_string_literal: true

require 'spec_helper'
require_relative '../src/environment_helper'

describe EnvironmentHelper do
  let(:names_map) { 'github_name:rocket_name' }
  let(:rocket_channel) { 'rocket_channel' }
  let(:rocket_url) { 'rocket_url' }
  let(:rocket_username) { 'rocket_username' }
  let(:rocket_password) { 'rocket_password' }
  let(:github_access_token) { 'github_access_token' }
  let(:organization) { 'organization' }
  let(:api_token) { 'api_token' }
  let(:environment) do
    {
      'NAMES_MAP' => names_map,
      'ROCKET_CHANNEL' => rocket_channel,
      'ROCKET_URL' => rocket_url,
      'ROCKET_USERNAME' => rocket_username,
      'ROCKET_PASSWORD' => rocket_password,
      'GITHUB_ACCESS_TOKEN' => github_access_token,
      'ORGANIZATION' => organization,
      'API_TOKEN' => api_token
    }
  end

  describe '.missing_configuration' do
    it 'returns the missing configuration' do
      with_modified_env(environment) do
        expect(described_class.missing_configuration).to eq([])
      end
    end

    context 'when the names map is missing' do
      let(:names_map) { nil }

      it 'returns the missing configuration' do
        with_modified_env(environment) do
          expect(described_class.missing_configuration).to eq([:names_map])
        end
      end
    end

    context 'when the rocket channel is missing' do
      let(:rocket_channel) { nil }

      it 'returns the missing configuration' do
        with_modified_env(environment) do
          expect(described_class.missing_configuration).to eq([:rocket_channel])
        end
      end
    end

    context 'when the rocket url is missing' do
      let(:rocket_url) { nil }

      it 'returns the missing configuration' do
        with_modified_env(environment) do
          expect(described_class.missing_configuration).to eq([:rocket_url])
        end
      end
    end

    context 'when the rocket username is missing' do
      let(:rocket_username) { nil }

      it 'returns the missing configuration' do
        with_modified_env(environment) do
          expect(described_class.missing_configuration).to eq([:rocket_username])
        end
      end
    end

    context 'when the rocket password is missing' do
      let(:rocket_password) { nil }

      it 'returns the missing configuration' do
        with_modified_env(environment) do
          expect(described_class.missing_configuration).to eq([:rocket_password])
        end
      end
    end

    context 'when the github access token is missing' do
      let(:github_access_token) { nil }

      it 'returns the missing configuration' do
        with_modified_env(environment) do
          expect(described_class.missing_configuration).to eq([:github_access_token])
        end
      end
    end

    context 'when the organization is missing' do
      let(:organization) { nil }

      it 'returns the missing configuration' do
        with_modified_env(environment) do
          expect(described_class.missing_configuration).to eq([:organization])
        end
      end
    end

    context 'when the api token is missing' do
      let(:api_token) { nil }

      it 'returns the missing configuration' do
        with_modified_env(environment) do
          expect(described_class.missing_configuration).to eq([:api_token])
        end
      end
    end
  end

  describe '.for' do
    it 'returns the value for the key' do
      with_modified_env(environment) do
        expect(described_class.for(:names_map)).to eq(names_map)
      end
    end
  end

  describe '.working_configuration?' do
    it 'returns true when the configuration is working' do
      with_modified_env(environment) do
        expect(described_class).to be_working_configuration
      end
    end

    context 'when the names map is missing' do
      let(:names_map) { nil }

      it 'returns false when the configuration is not working' do
        with_modified_env(environment) do
          expect(described_class).not_to be_working_configuration
        end
      end
    end

    context 'when the rocket channel is missing' do
      let(:rocket_channel) { nil }

      it 'returns false when the configuration is not working' do
        with_modified_env(environment) do
          expect(described_class).not_to be_working_configuration
        end
      end
    end

    context 'when the rocket url is missing' do
      let(:rocket_url) { nil }

      it 'returns false when the configuration is not working' do
        with_modified_env(environment) do
          expect(described_class).not_to be_working_configuration
        end
      end
    end

    context 'when the rocket username is missing' do
      let(:rocket_username) { nil }

      it 'returns false when the configuration is not working' do
        with_modified_env(environment) do
          expect(described_class).not_to be_working_configuration
        end
      end
    end

    context 'when the rocket password is missing' do
      let(:rocket_password) { nil }

      it 'returns false when the configuration is not working' do
        with_modified_env(environment) do
          expect(described_class).not_to be_working_configuration
        end
      end
    end

    context 'when the github access token is missing' do
      let(:github_access_token) { nil }

      it 'returns false when the configuration is not working' do
        with_modified_env(environment) do
          expect(described_class).not_to be_working_configuration
        end
      end
    end

    context 'when the organization is missing' do
      let(:organization) { nil }

      it 'returns false when the configuration is not working' do
        with_modified_env(environment) do
          expect(described_class).not_to be_working_configuration
        end
      end
    end
  end
end
