require 'autodesk/forge/api'

module Autodesk
  class Forge
    module AccModelProperties
      class Index < Forge::API
        def initialize(project_id:, index_id: nil, credentials:)
          @project_id = project_id
          @index_id = index_id
          @credentials = credentials
        end

        def create(urn)
          body = {
            versions: [
              { versionUrn: urn }
            ]
          }
          response = post_request("/construction/index/v2/projects/#{@project_id}/indexes:batch-status", body)

          JSON.parse(response.body)
        end

        def get
          response = get_request("/construction/index/v2/projects/#{@project_id}/indexes/#{@index_id}")

          JSON.parse(response.body)
        end

      end
    end
  end
end