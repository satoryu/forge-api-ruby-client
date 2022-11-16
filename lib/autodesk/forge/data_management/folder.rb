require 'autodesk/forge/api'

module Autodesk
  class Forge
    module DataManagement
      class Folder < Forge::API
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
      end
    end
  end
end
