json.source_url @url_shortener.source_url
json.shorten_key @url_shortener.shorten_key
json.shorten_url url_for(
  controller: 'api/url_shorteners', action: 'redirect', shorten_key: @url_shortener.shorten_key, only_path: false
)
