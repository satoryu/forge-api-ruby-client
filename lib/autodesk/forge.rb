# frozen_string_literal: true

require_relative "forge/version"

module Autodesk
  class Forge
    def authenticate
      { access_token: 'dummy-access-token' }
    end
  end
end
