class UrlShortenersController < ApplicationController
  api :POST, '/encode'
  param :url, String, desc: 'The URL you want to be shortened', required: true
  returns code: 200, desc: "a successful response" do
    property :shorten_key, String, :desc => "Encoded shorten key"
    property :shorten_url, String, :desc => "URL with Encoded shorten key"
  end
  def encode
    @svc = ShortenerService.call(params[:url]).result
  end

  api :GET, '/decode/:shorten_key'
  param :source_url, String, desc: 'The URL you want to be shortened'
  returns code: 200, desc: "a successful response" do
    property :shorten_key, String, :desc => "Encoded shorten key"
    property :shorten_url, String, :desc => "URL with Encoded shorten key"
  end
  returns code: 404, desc: "Not found Error"
  def decode
    get_resource_by_shorten_key
  end

  def redirect
    get_resource_by_shorten_key
    redirect_to @url_shortener.source_url, allow_other_host: true
  end

  private

  def get_resource_by_shorten_key
    @url_shortener = UrlShortener.where(shorten_key: params[:shorten_key]).first
    raise Utils::JsonError.new('record_not_found', 404) unless @url_shortener
  end
end
