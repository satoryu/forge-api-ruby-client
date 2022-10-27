require 'net/http'
require 'json'
require 'uri'

module Autodesk
  class Forge
    module DataManagement
      class Folder
        def initialize(project_id:, credentials:)
          @project_id = project_id
          @credentials = credentials
        end

        def get(folder_id)
          http = Net::HTTP.new('developer.api.autodesk.com', 443)
          http.use_ssl = true
          headers = { Authorization: "Bearer #{@credentials['access_token']}"}

          response = http.get("/data/v1/projects/#{@project_id}/folders/#{URI.encode_www_form_component(folder_id)}", headers)

          JSON.parse(response.body)
        end
      end
    end
  end
end
