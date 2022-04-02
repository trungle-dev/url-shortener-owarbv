require 'uri'

class UrlShortener
  include Mongoid::Document
  include Mongoid::Timestamps
  field :shorten_key, type: String
  field :source_url, type: String

  validate_presence_of :source_url
  before_validation :validate_source_url

  index({ shorten_key: 1 }, { unique: true, name: 'shorten_key_index' })

  def validate_source_url
    uri = URI.parse(source_url) && source_url.host
  rescue URI::InvalidURIError
    errors[:source_url] << 'is not an url'
  end
end
