require 'httparty'
require 'active_support/core_ext/module'

module Truepill

  ##
  # Truepill Request class
  #
  # Represents an authenticated request to the Truepill API.
  #
  # Not used directly. RestfulResource inherits from this and implements the core, common
  # methods used by the API.
  #

  class Request
    include HTTParty
    debug_output

    def get(path)
      perform_checks(path)
      url = build_url(path)
      response = send_authenticated(__callee__, url)
      Response.new(response)
    end
    alias_method :delete, :get

    def post(path, data = {})
      perform_checks(path)
      url = build_url(path)
      response = send_authenticated(__callee__, url, data)
      Response.new(response)
    end
    alias_method :put, :post
    alias_method :patch, :post

    private

    def send_authenticated(method, url, data = {})
      options = if data[:multipart]
        # don't covert to json here for multipart because it messes with files.
        { body: data, multipart: true }
      else
        { body: data.to_json }
      end
      options.merge!(headers: headers(data))

      response = self.class.public_send(
        method, url, options
      )

      if response.code == 401
        raise ::Truepill::AuthError, 'The token is invalid'
      else
        response
      end
    end

    def api_domain
      if Truepill.configuration.production?
        'api.truepill.com'
      else
        'api.falsepill.com'
      end
    end

    def build_url(path)
      ['https://', api_domain, '/v1/', path].join
    end

    JSON_CONTENT_TYPE = 'application/json'
    MULTIPART_CONTENT_TYPE = 'multipart/form-data'

    def headers(data = {})
      content_type = data[:multipart] ? MULTIPART_CONTENT_TYPE : JSON_CONTENT_TYPE
      { Authorization: "ApiKey #{Truepill.configuration.api_key}",
        'Content-Type': content_type }
    end

    def perform_checks(path)
      if Truepill.configuration.api_key.blank?
        raise ::Truepill::AccessTokenNotPresentError, "Truepill access token not present"
      end

      # path must:
      # * not be blank
      # * contain a path besides just "/"
      if path.blank? || path.gsub('/', '').empty?
        raise ::Truepill::InvalidApiUrlError "Truepill API path passed appears invalid: #{path}"
      end
    end

  end

end
