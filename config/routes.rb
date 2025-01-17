Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'auth/login', to: 'authentication#login'


  get 'beers/all', to: 'beers#get_all'
  get 'beers/favs', to: 'beers#get_favs'
  get 'beers/:id/fav', to: 'beers#toggle_fav'

  resources :beers
end
