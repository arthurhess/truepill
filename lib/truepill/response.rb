module Truepill

  ##
  # Truepill Response class
  #
  # Encapsulates a parsed json response from Truepill's API with methods
  # for things like HTTP status codes, etc.
  #

  class Response

    attr_reader :response
    delegate :body, :code, :message, :headers, :parsed_response, to: :response

    def initialize(response)
      @response = response
    end

    def success?
      %w(success processed).include?(data[:status]) || !error?
    end

    def error?
      code.to_i / 100 != 2 || data[:statusCode] == 400
    end

    def errors
      data[:validation_errors]&.map do |error_data|
        "#{error_data[:key]} #{error_data[:message]}"
      end
    end

    def error_message
      errors&.join(', ')
    end

    ##
    # Parsed response (e.g. Hash version of json received back)
    #

    def data
      if parsed_response.is_a?(Hash)
        parsed_response&.with_indifferent_access
      elsif parsed_response.is_a?(Array)
        parsed_response.map(&:with_indifferent_access)
      else
        parsed_response
      end
    rescue JSON::ParserError
      # if the server sends an invalid response
      body
    end

  end

end
