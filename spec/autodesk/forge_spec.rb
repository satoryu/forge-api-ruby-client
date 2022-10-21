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

      context 'When giving two scopes' do
        it 'sends the scope as a parameter concatinating URL encoded space' do
          stub_authentication = stub_request(:post, 'https://developer.api.autodesk.com/authentication/v1/authenticate')
            .with(body: hash_including(client_id: 'dummy-client-id', client_secret: 'dummy-client-secret', grant_type: 'client_credentials', scope: 'data:read data:write'))
            .to_return({ body: { access_token: 'dummy-access-token'}.to_json })

          forge = Autodesk::Forge.new(client_id: 'dummy-client-id', client_secret: 'dummy-client-secret', scope: 'data:read%20data:write')
          credential = forge.authenticate

          expect(credential).to include('access_token' => 'dummy-access-token')
          expect(stub_authentication).to have_been_requested
        end
      end
      context 'When getting error response' do
        it 'raises an exception' do
          stub_authentication = stub_request(:post, 'https://developer.api.autodesk.com/authentication/v1/authenticate')
            .with(body: hash_including(client_id: 'dummy-client-id', client_secret: 'dummy-client-secret', grant_type: 'client_credentials'))
            .to_return({ status: 400, body: { errorCode: 'AUTH-001', developerMessage: 'the client_id is not authorized', userMessage: '', 'more info' => 'https://developer.api.autodesk.com/documentation/v1/errors/AUTH-001'}.to_json })

            forge = Autodesk::Forge.new(client_id: 'dummy-client-id', client_secret: 'dummy-client-secret', scope: 'data:read%20data:write')

            expect { forge.authenticate }.to raise_error(Exception)
            expect(stub_authentication).to have_been_requested
        end
      end
    end
  end
end
