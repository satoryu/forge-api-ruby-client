require 'autodesk/forge/api'

module Autodesk
  class Forge
    module ModelDerivative
      class Manifest < Forge::API
        def initialize(credentials:)
          @credentials = credentials
        end

        def get(urn)
          response = get_request("/modelderivative/v2/designdata/#{URI.encode_www_form_component(urn)}/manifest")

          JSON.parse(response.body)
        end
      end
    end
  end
end