require 'autodesk/forge/api'

module Autodesk
  class Forge
    module ModelDerivative
      class Manifest < Forge::API
        def initialize(credentials:, urn: nil)
          @credentials = credentials
          @urn = urn
        end

        def get(urn)
          response = get_request("/modelderivative/v2/designdata/#{URI.encode_www_form_component(urn)}/manifest")

          JSON.parse(response.body)
        end

        def derivative_download_url(derivative_urn)
          response = get_request("/modelderivative/v2/designdata/#{URI.encode_www_form_component(@urn)}/manifest/#{derivative_urn}/signedcookies")

          response
        end
      end
    end
  end
end