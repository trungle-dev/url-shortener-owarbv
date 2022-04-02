class ShortenerService
  prepend SimpleCommand

  attr_reader :url, :url_shortener

  def initialize(url)
    @url = url
  end

  def call
    idx = IncrementalService.call.result
    shorten_key = EncoderService.call(idx).result
    create_url_shortener(shorten_key)
  end

  private

  def create_url_shortener(shorten_key)
    @url_shortener = UrlShortener.new(
      shorten_key: shorten_key,
      source_url: @url
    )

    unless @url_shortener.save
      raise Utils::JsonError.new(@url_shortener.errors.full_messages, 422)
    end

    @url_shortener
  rescue Mongo::Error::OperationFailure => e
    if e.code == 11000
      raise Utils::JsonError.new('duplicate_key', 422)
    else
      raise e
    end
  end
end
