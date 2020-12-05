RSpec.describe Truepill::Resources::FillRequest do
  include_context 'with sandbox configuration'

  let(:resource_base_path) { "fill_request" }
  let(:arguments) { [] }

  it_behaves_like 'a create action'
  it_behaves_like 'a read action'
end
