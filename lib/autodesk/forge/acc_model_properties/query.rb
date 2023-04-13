require 'autodesk/forge/api'

module Autodesk
  class Forge
    module AccModelProperties
      class Query < Forge::API
        def initialize(project_id:, index_id:, query_id: nil, credentials:)
          @project_id = project_id
          @index_id = index_id
          @query_id = query_id
          @credentials = credentials
        end

        def create(parameter)
          response = post_request("/construction/index/v2/projects/#{@project_id}/indexes/#{@index_id}/queries", parameter)

          JSON.parse(response.body)
        end

        def get
          response = get_request("/construction/index/v2/projects/#{@project_id}/indexes/#{@index_id}/queries/#{@query_id}")

          JSON.parse(response.body)
        end

        def properties
          response = get_request("/construction/index/v2/projects/#{@project_id}/indexes/#{@index_id}/queries/#{@query_id}/properties")
          data = "{ \"data\": [#{response.body.gsub(/\n/, ',')}]}"
          JSON.parse(data)
        end

      end
    end
  end
end