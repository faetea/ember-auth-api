Rails.application.routes.draw do
  resources :arts, except: [:new, :edit]
  resources :collections, except: [:new, :edit]
  get '/mycollections' => 'collections#my_collections'
  resources :users, only: [:index, :show, :update]
  post '/sign-up' => 'users#signup'
  post '/sign-in' => 'users#signin'
  patch '/change-password/:id' => 'users#changepw'
  delete '/sign-out/:id' => 'users#signout'
end
