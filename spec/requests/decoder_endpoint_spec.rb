require 'rails_helper'

RSpec.describe UrlShortenersController, type: :request do
  let(:decode_endpoint) { '/encode' }

  context 'when all input are valid' do
    let(:url) { 'http://google.com' }

    before do
      post decode_endpoint, params: { url: url }
    end

    it 'expect response to be in solid format' do
      expect(response).to have_http_status(:success)

      body = JSON.parse(response.body)
      expect(body['shorten_key']).to be_present

      url_shortener = UrlShortener.find_by(shorten_key: body['shorten_key'])
      expect(url_shortener).to be_present
      expect(body['source_url']).to eq(url_shortener.source_url)
      expect(body['shorten_key']).to eq(url_shortener.shorten_key)
      expect(body['shorten_url']).to be_present
    end
  end

  context 'when all input url are not valid' do
    shared_examples '/encode response error' do |url, error_message|
      before do
        post decode_endpoint, params: { url: url }
      end
      it "expect response to be an error array object with message #{error_message}" do
        expect(response.status).to eq(422)
        body = JSON.parse(response.body)
        expect(body.class).to eq(Array)
        expect(body).to be_present
        expect(body).to include({ 'message' => error_message })
      end
    end

    include_examples '/encode response error', 'invalidurl', 'Source url is invalid'
    include_examples '/encode response error', '', "Source url can't be blank"
  end
end
