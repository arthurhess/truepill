RSpec.shared_context 'with sandbox configuration' do
  before do
    ::Truepill.configure do |config|
      config.environment = :sandbox
    end
  end
end
