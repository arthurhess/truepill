RSpec.describe Truepill::Configuration do

  it "has an environment string" do

    Truepill.configure do |config|
      config.environment = 'sandbox'
    end

    expect(Truepill.configuration.environment).to eq(:sandbox)
  end

end

