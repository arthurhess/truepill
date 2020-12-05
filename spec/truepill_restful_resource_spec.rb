RSpec.describe Truepill::RestfulResource do
  include_context 'with sandbox configuration'

  context "#resource_base" do
    it "is an underscored pluralized version of the class name" do
      resource = Truepill::RestfulResource.new
      expect(resource.send(:resource_base)).to eq('restful_resource')
    end
  end

  context "#resource_path" do
    it "is the base resource path for the class plus the passed identifier" do
      resource = Truepill::RestfulResource.new
      expect(resource.send(:resource_path, 123)).to eq('restful_resource/123/')
    end
  end

end
