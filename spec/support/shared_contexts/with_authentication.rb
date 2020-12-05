RSpec.shared_context 'with authentication' do
  before do
    ENV['TRUEPILL_API_KEY'] = 'test_key'
  end
end
