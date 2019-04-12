Rails.application.routes.draw do
  get '/shorten', to: 'link#create'
  get '/custom', to: 'link#custom'
  get '/stats', to: 'link#index'
  get '/:slug', to: 'link#show'
end
