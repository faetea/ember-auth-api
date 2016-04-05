Rails.application.routes.draw do
  resources :arts, except: [:new, :edit]
  resources :collections, except: [:new, :edit]  
  post '/sign-up' => 'users#signup'
  post '/sign-in' => 'users#signin'
  delete '/sign-out/:id' => 'users#signout'
  patch '/change-password/:id' => 'users#changepw'
  resources :users, only: [:index, :show]
end
