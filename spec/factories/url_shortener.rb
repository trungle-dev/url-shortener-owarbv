FactoryBot.define do
  factory :url_shortener do
    shorten_key { SecureRandom.base64(6) }
    source_url  { 'https://localhost:3000' }
  end
end
