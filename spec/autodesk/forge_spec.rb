# frozen_string_literal: true

RSpec.describe Autodesk::Forge do
  describe '.authenticate' do
    it 'responds credential' do
      forge = Autodesk::Forge.new
      credential = forge.authenticate

      expect(credential).to include(access_token: 'dummy-access-token')
    end
  end
end
