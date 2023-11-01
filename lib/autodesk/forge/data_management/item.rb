require 'autodesk/forge/api'

module Autodesk
  class Forge
    module DataManagement
      class Item < Forge::API
        def initialize(project_id:, item_id:, credentials:)
          @project_id = project_id
          @item_id = item_id
          @credentials = credentials
        end

        def versions
          response = get_request("/data/v1/projects/#{@project_id}/items/#{URI.encode_www_form_component(@item_id)}/versions")

          JSON.parse(response.body)
        end

        def get
          response = get_request("/data/v1/projects/#{@project_id}/items/#{URI.encode_www_form_component(@item_id)}")

          JSON.parse(response.body)
        end
      end
    end
  end
end