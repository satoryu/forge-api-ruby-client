require 'autodesk/forge/api'

module Autodesk
  class Forge
    module DataManagement
      class Version < Forge::API
        def initialize(project_id:, credentials:)
          @credentials = credentials
          @project_id = project_id
        end

        def get(urn)
          response = get_request("/data/v1/projects/#{@project_id}/versions/#{URI.encode_www_form_component(urn)}")

          JSON.parse(response.body)
        end
      end
    end
  end
end