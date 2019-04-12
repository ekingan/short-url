Rails.application.routes.draw do
  get '/shorten', to: 'link#create'
  get '/custom', to: 'link#custom'
  get '/:slug', to: 'link#show'
  get '/stats', to: 'link#index'
end