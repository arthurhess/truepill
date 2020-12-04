# order matters
require "truepill/authentication"
require "truepill/configuration"
require "truepill/request"
require "truepill/restful_resource"
require "truepill/response"
require "truepill/version"

resources_path = File.expand_path('truepill/resources/*.rb', File.dirname(__FILE__))
Dir[resources_path].each { |f| require f[/\/lib\/(.+)\.rb$/, 1] }

require 'active_support/core_ext/hash'

module Truepill

  class AuthError < StandardError; end
  class AccessTokenNotPresentError < StandardError; end
  class InvalidApiUrlError < StandardError; end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

end
