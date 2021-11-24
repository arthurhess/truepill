RSpec.describe Truepill::Configuration do
  subject(:config) { Truepill.configuration }

  context 'with default configuration' do
    before do
      Truepill.configure do |config|
        config.api_key = '123'
      end
    end

    its(:environment) { is_expected.to eq :sandbox }
    its(:production?) { is_expected.to be_falsey }
    its(:sandbox?) { is_expected.to be_truthy }
    its(:api_key) { is_expected.to eq '123' }
    its(:ssl_version) { is_expected.to eq Truepill::Configuration::DEFAULT_SSL_VERSION }
  end

  context 'with custom attributes' do
    before do
      Truepill.configure do |config|
        config.environment = 'production'
        config.api_key = '456'
        config.ssl_version = :TLSv1_1
      end
    end

    its(:environment) { is_expected.to eq :production }
    its(:production?) { is_expected.to be_truthy }
    its(:sandbox?) { is_expected.to be_falsey }
    its(:api_key) { is_expected.to eq '456' }
    its(:ssl_version) { is_expected.to eq :TLSv1_1 }
  end
end
