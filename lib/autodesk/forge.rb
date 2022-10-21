# frozen_string_literal: true

require_relative "forge/version"

require 'net/http'
require 'json'

module Autodesk
  class Forge
    def initialize(client_id:, client_secret:)
      @client_id = client_id
      @client_secret = client_secret
    end

    def authenticate
      http = Net::HTTP.new('developer.api.autodesk.com', 443)
      http.use_ssl = true
      params = { client_id: @client_id, client_secret: @client_secret, grant_type: 'client_credentials'}

      body = params.map { |k, v| "#{k}=#{v}" }.join('&')
      response = http.post('/authentication/v1/authenticate', body)

      JSON.parse(response.body)
    end
  end
end
