require 'rails_helper'

RSpec.describe UrlShortenersController, type: :request do
  let(:decode_endpoint) { '/decode' }

  context 'When get exist shorten_key in db' do
    let(:url_shortener) { create(:url_shortener) }
    before do
      get "/decode/#{url_shortener.shorten_key}"
    end

    it 'expect response to be in solid format' do
      expect(response).to have_http_status(:success)

      body = JSON.parse(response.body)

      expect(url_shortener).to be_present
      expect(body['source_url']).to eq(url_shortener.source_url)
      expect(body['shorten_key']).to eq(url_shortener.shorten_key)
      expect(body['shorten_url']).to be_present
    end
  end

  context 'When get non exist shorten_key' do
    before do
      get "/decode/non_exist"
    end

    it 'expect response to be in solid format' do
      expect(response.status).to eq(404)
      body = JSON.parse(response.body)
      expect(body.class).to eq(Array)
      expect(body).to be_present
      expect(body).to include({ 'message' => 'record_not_found' })
    end
  end
end
