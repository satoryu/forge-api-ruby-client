require 'spec_helper'

RSpec.describe Autodesk::Forge::DataManagement::Version do
  describe '#get' do
    let(:project_id) { 'dummy-project-id' }
    let(:urn) { 'dummy-urn' }

    it 'sends a request to the endpoint' do
      stub_hubs = stub_request(:get, "https://developer.api.autodesk.com/data/v1/projects/#{project_id}/versions/#{URI.encode_www_form_component(urn)}")
        .with(headers: { Authorization: 'Bearer dummy-access-token'})
        .to_return({ body: { data: 'dummy-data' }.to_json })

      credentials = { 'access_token' => 'dummy-access-token' }

      version = Autodesk::Forge::DataManagement::Version.new(project_id: project_id, credentials: credentials)
      version = version.get(urn)

      expect(stub_hubs).to have_been_requested
      expect(version['data']).to be_eql('dummy-data')
    end
  end
end
