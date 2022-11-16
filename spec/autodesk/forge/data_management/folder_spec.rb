require 'spec_helper'

require 'uri'

RSpec.describe Autodesk::Forge::DataManagement::Folder do
  describe '#get' do
    let(:project_id) { 'dummy-project-id'}
    let(:folder_id) { 'dummy-folder-id'}

    it 'sends a request to the endpoint' do
      stub_hubs = stub_request(:get, "https://developer.api.autodesk.com/data/v1/projects/#{project_id}/folders/#{URI.encode_www_form_component(folder_id)}")
        .with(headers: { Authorization: 'Bearer dummy-access-token'})
        .to_return({ body: { data: 'dummy-data' }.to_json })

      credentials = { 'access_token' => 'dummy-access-token' }

      folders = Autodesk::Forge::DataManagement::Folder.new(project_id: project_id, credentials: credentials)
      folder = folders.get(folder_id)

      expect(stub_hubs).to have_been_requested
      expect(folder['data']).to be_eql('dummy-data')
    end
  end
end
