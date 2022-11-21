require 'spec_helper'

RSpec.describe Autodesk::Forge::ModelDerivative::Manifest do
  describe '#get' do
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

  describe '#derivative_download_url' do
    let(:urn) { 'dummy_Urn' }
    let(:derivative_urn) { 'dummy_derivative_urn' }

    it 'sends a request to the endpoint' do
      signed_cookies = [
        'first-header=first-value',
        'second-header=second-value',
        'third-header=third-value'
      ]

      stub_hubs = stub_request(:get, "https://developer.api.autodesk.com/modelderivative/v2/designdata/#{URI.encode_www_form_component(urn)}/manifest/#{derivative_urn}/signedcookies")
        .with(headers: { Authorization: 'Bearer dummy-access-token'})
        .to_return({ body: { data: 'dummy-data' }.to_json, headers: { 'Set-Cookie' => signed_cookies } })

      credentials = { 'access_token' => 'dummy-access-token' }

      manifest = Autodesk::Forge::ModelDerivative::Manifest.new(urn: urn, credentials: credentials)
      derivative_download_url = manifest.derivative_download_url(derivative_urn)

      expect(stub_hubs).to have_been_requested
      expect(derivative_download_url['Set-Cookie'].split(',').map(&:strip)).to match_array(signed_cookies)
    end
  end
end
