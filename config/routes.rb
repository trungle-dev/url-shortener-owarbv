Rails.application.routes.draw do
  apipie
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post :encode, to: 'url_shorteners#encode', defaults: { format: 'json' }
  get 'decode/:shorten_key', to: 'url_shorteners#decode', defaults: { format: 'json' }
  get ':shorten_key', to: 'url_shorteners#redirect'
end
