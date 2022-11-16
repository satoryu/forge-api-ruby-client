require 'spec_helper'

RSpec.describe Autodesk::Forge::DataManagement::Item do
  describe '#versions' do
    let(:project_id) { 'dummy-project-id'}
    let(:item_id) { 'dummy-item-id'}

    it 'sends a request to the endpoint' do
      stub_hubs = stub_request(:get, "https://developer.api.autodesk.com/data/v1/projects/#{project_id}/items/#{URI.encode_www_form_component(item_id)}/versions")
        .with(headers: { Authorization: 'Bearer dummy-access-token'})
        .to_return({ body: { data: 'dummy-data' }.to_json })

      credentials = { 'access_token' => 'dummy-access-token' }

      item = Autodesk::Forge::DataManagement::Item.new(project_id: project_id, item_id: item_id, credentials: credentials)
      versions = item.versions

      expect(stub_hubs).to have_been_requested
      expect(versions['data']).to be_eql('dummy-data')
    end
  end
end