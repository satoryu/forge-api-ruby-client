require 'spec_helper'

RSpec.describe Autodesk::Forge::AccModelProperties::Query do
  describe '#create' do
    let(:project_id) { 'dummy_ProjectId' }
    let(:index_id) { 'dummy_IndexId' }

    it 'sends a request to the endpoint' do
      body = {
        query: "test query",
        columns: "test column"
      }
      
      stub_hubs = stub_request(:post, "https://developer.api.autodesk.com/construction/index/v2/projects/#{project_id}/indexes/#{index_id}/queries")
        .with(headers: { Authorization: 'Bearer dummy-access-token', "Content-Type" => 'application/json'}, body: body)
        .to_return({ body: { data: 'dummy-data' }.to_json })

      credentials = { 'access_token' => 'dummy-access-token' }

      query = Autodesk::Forge::AccModelProperties::Query.new(project_id: project_id, index_id: index_id, credentials: credentials)
      query = query.create(body)

      expect(stub_hubs).to have_been_requested
      expect(query['data']).to be_eql('dummy-data')
    end
  end

  describe '#get' do
    let(:project_id) { 'dummy_ProjectId' }
    let(:index_id) { 'dummy_IndexId' }
    let(:query_id) { 'dummy_QueryId' }

    it 'sends a request to the endpoint' do
      stub_hubs = stub_request(:get, "https://developer.api.autodesk.com/construction/index/v2/projects/#{project_id}/indexes/#{index_id}/queries/#{query_id}")
        .with(headers: { Authorization: 'Bearer dummy-access-token'})
        .to_return({ body: { data: 'dummy-data' }.to_json })

      credentials = { 'access_token' => 'dummy-access-token' }

      query = Autodesk::Forge::AccModelProperties::Query.new(project_id: project_id, index_id: index_id, query_id: query_id, credentials: credentials)
      query = query.get()

      expect(stub_hubs).to have_been_requested
      expect(query['data']).to be_eql('dummy-data')
    end
  end
  
  describe '#properties' do
    let(:project_id) { 'dummy_ProjectId' }
    let(:index_id) { 'dummy_IndexId' }
    let(:query_id) { 'dummy_QueryId' }

    it 'sends a request to the endpoint' do
      stub_hubs = stub_request(:get, "https://developer.api.autodesk.com/construction/index/v2/projects/#{project_id}/indexes/#{index_id}/queries/#{query_id}/properties")
        .with(headers: { Authorization: 'Bearer dummy-access-token'})
        .to_return({ body: { data: 'dummy-data' }.to_json })

      credentials = { 'access_token' => 'dummy-access-token' }

      query = Autodesk::Forge::AccModelProperties::Query.new(project_id: project_id, index_id: index_id, query_id: query_id, credentials: credentials)
      query = query.properties()

      expect(stub_hubs).to have_been_requested
      expect(query['data']).to be_eql('dummy-data')
    end
  end

end
