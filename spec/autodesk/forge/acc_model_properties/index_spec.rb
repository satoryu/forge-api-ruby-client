require 'spec_helper'

RSpec.describe Autodesk::Forge::AccModelProperties::Index do
  describe '#create' do
    let(:project_id) { 'dummy_ProjectId' }
    let(:urn) { 'dummy_Urn' }

    it 'sends a request to the endpoint' do
      stub_hubs = stub_request(:post, "https://developer.api.autodesk.com/construction/index/v2/projects/#{project_id}/indexes:batch-status")
        .with(headers: { Authorization: 'Bearer dummy-access-token', "Content-Type" => 'application/json'}, body: { versions: [{ versionUrn: urn }] })
        .to_return({ body: { data: 'dummy-data' }.to_json })

      credentials = { 'access_token' => 'dummy-access-token' }

      index = Autodesk::Forge::AccModelProperties::Index.new(project_id: project_id, credentials: credentials)
      index = index.create(urn)

      expect(stub_hubs).to have_been_requested
      expect(index['data']).to be_eql('dummy-data')
    end
  end

  describe '#get' do
    let(:project_id) { 'dummy_ProjectId' }
    let(:index_id) { 'dummy_IndexId' }

    it 'sends a request to the endpoint' do
      stub_hubs = stub_request(:get, "https://developer.api.autodesk.com/construction/index/v2/projects/#{project_id}/indexes/#{index_id}")
        .with(headers: { Authorization: 'Bearer dummy-access-token'})
        .to_return({ body: { data: 'dummy-data' }.to_json })

      credentials = { 'access_token' => 'dummy-access-token' }

      index = Autodesk::Forge::AccModelProperties::Index.new(project_id: project_id, index_id: index_id, credentials: credentials)
      index = index.get()

      expect(stub_hubs).to have_been_requested
      expect(index['data']).to be_eql('dummy-data')
    end
  end

end
