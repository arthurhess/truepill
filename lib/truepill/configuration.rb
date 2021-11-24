module Truepill
  ##
  # Truepill Configuration class
  #

  class Configuration
    DEFAULT_SSL_VERSION = :TLSv1_2

    # [String] Environment to use - 'production' or 'sandbox'
    attr_reader :environment
    # [String] Client API Key (obtain from the Truepill portal)
    attr_accessor :api_key
    # [String] SSL Version, optional, TLS 1.2 by default
    attr_accessor :ssl_version

    def initialize
      # default to sandbox environment
      @environment = :sandbox
      # use the default version
      @ssl_version = DEFAULT_SSL_VERSION
    end

    def production?
      environment == :production
    end

    def sandbox?
      environment == :sandbox
    end

    def environment=(environment = :sandbox)
      @environment = environment.to_sym
    end
  end
end
