Rails.application.routes.draw do

  root to: 'movies#home'

  get '/movies/:imdbID', to: 'movies#show', as: 'movies'
  get '/results', to: 'movies#results', as: 'results'

end
