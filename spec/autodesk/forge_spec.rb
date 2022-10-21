# frozen_string_literal: true

RSpec.describe Autodesk::Forge do
  describe '.authenticate' do
    it 'responds credential' do
      stub_authentication = stub_request(:post, 'https://developer.api.autodesk.com/authentication/v1/authenticate')
        .with(body: hash_including(client_id: 'dummy-client-id', client_secret: 'dummy-client-secret', grant_type: 'client_credentials'))
        .to_return({ body: { access_token: 'dummy-access-token'}.to_json })

      forge = Autodesk::Forge.new client_id: 'dummy-client-id', client_secret: 'dummy-client-secret'
      credential = forge.authenticate

      expect(credential).to include('access_token' => 'dummy-access-token')
      expect(stub_authentication).to have_been_requested
    end
    context 'When given scope' do
      it 'sends the scope as a parameter to authenticate API' do
        stub_authentication = stub_request(:post, 'https://developer.api.autodesk.com/authentication/v1/authenticate')
          .with(body: hash_including(client_id: 'dummy-client-id', client_secret: 'dummy-client-secret', grant_type: 'client_credentials', scope: 'read'))
          .to_return({ body: { access_token: 'dummy-access-token'}.to_json })

        forge = Autodesk::Forge.new client_id: 'dummy-client-id', client_secret: 'dummy-client-secret', scope: 'read'
        credential = forge.authenticate

        expect(credential).to include('access_token' => 'dummy-access-token')
        expect(stub_authentication).to have_been_requested
      end
    end
  end
end
