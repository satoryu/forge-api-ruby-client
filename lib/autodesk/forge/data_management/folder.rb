require 'net/http'
require 'json'
require 'uri'

module Autodesk
  class Forge
    module DataManagement
      class Folder
        def initialize(project_id:, folder_id: nil, credentials:)
          @project_id = project_id
          @folder_id = folder_id
          @credentials = credentials
        end

        def get(folder_id)
          response = get_request("/data/v1/projects/#{@project_id}/folders/#{URI.encode_www_form_component(folder_id)}")

          JSON.parse(response.body)
        end

        def contents
          response = get_request("/data/v1/projects/#{@project_id}/folders/#{URI.encode_www_form_component(@folder_id)}/contents")

          JSON.parse(response.body)
        end

        private
          def http_client
            return @http_client if @http_client

            @http_client = Net::HTTP.new('developer.api.autodesk.com', 443)
            @http_client.use_ssl = true

            @http_client
          end

          def get_request(path)
            headers = { Authorization: "Bearer #{@credentials['access_token']}"}

            http_client.get(path, headers)
          end
      end
    end
  end
end
