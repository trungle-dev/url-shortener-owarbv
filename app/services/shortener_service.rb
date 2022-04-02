class ShortenerService
  attr_reader :errors, :url, :url_shortener

  def initialize(url)
    @url = url
  end

  def call
    idx = IncrementalService.call
    shorten_key = Base62.encode(idx)
    @url_shortener = UrlShortener.new(
      shorten_key: shorten_key,
      full_url: @url
    )

    unless @url_shortener.save
      @errors = @url_shortener.errors.full_messages
    end

    @url_shortener
  end
end
