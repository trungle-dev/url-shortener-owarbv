class ShortenerService
  prepend SimpleCommand

  attr_reader :errors, :url, :url_shortener

  def initialize(url)
    @url = url
  end

  def call
    idx = IncrementalService.call.result
    shorten_key = EncoderService.call(idx).result

    @url_shortener = UrlShortener.new(
      shorten_key: shorten_key,
      source_url: @url
    )

    unless @url_shortener.save
      @errors = @url_shortener.errors.full_messages
    end

    @url_shortener
  end
end
