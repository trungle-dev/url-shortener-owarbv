Rails.application.routes.draw do
  apipie
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: 'json' } do
    post :encode, to: 'url_shorteners#encode'
    get 'decode/:shorten_key', to: 'url_shorteners#decode'
  end
  get ':shorten_key', to: 'api/url_shorteners#redirect', as: :redirection
end
