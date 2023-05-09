# frozen_string_literal: true

require_relative "forge/version"

require_relative 'forge/data_management'
require_relative 'forge/model_derivative'

require 'net/http'
require 'json'

module Autodesk
  class Forge
    def initialize(client_id:, client_secret:, scope: nil)
      @client_id = client_id
      @client_secret = client_secret
      @scope = scope
    end

    def authenticate
      http = Net::HTTP.new('developer.api.autodesk.com', 443)
      http.use_ssl = true

      params = { grant_type: 'client_credentials'}
      params[:scope] = (Array === @scope ? @scope.join('%20') : @scope) if @scope
      body = params.map { |k, v| "#{k}=#{v}" }.join('&')

      authorization = Base64.strict_encode64("#{@client_id}:#{@client_secret}")
      headers = { 
        Authorization: "Basic #{authorization}",
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      response = http.post('/authentication/v2/token', body, headers)

      raise 'error response' if response.code >= '400'

      JSON.parse(response.body)
    end
  end
end
