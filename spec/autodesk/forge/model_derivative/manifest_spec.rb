require 'spec_helper'

RSpec.describe Autodesk::Forge::ModelDerivative::Manifest do
  let(:urn) { 'dummy_Urn' }

  it 'sends a request to the endpoint' do
    stub_hubs = stub_request(:get, "https://developer.api.autodesk.com/modelderivative/v2/designdata/#{URI.encode_www_form_component(urn)}/manifest")
      .with(headers: { Authorization: 'Bearer dummy-access-token'})
      .to_return({ body: { data: 'dummy-data' }.to_json })

    credentials = { 'access_token' => 'dummy-access-token' }

    manifest = Autodesk::Forge::ModelDerivative::Manifest.new(credentials: credentials)
    manifest = manifest.get(urn)

    expect(stub_hubs).to have_been_requested
    expect(manifest['data']).to be_eql('dummy-data')
  end
end