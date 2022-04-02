require 'uri'

class UrlShortener
  include ActiveModel::Validations
  include Mongoid::Document
  include Mongoid::Timestamps
  field :shorten_key, type: String
  field :source_url, type: String

  validates_presence_of :source_url
  validates :source_url, format: { with: URI.regexp }

  index({ shorten_key: 1 }, { unique: true, name: 'shorten_key_index' })
end
