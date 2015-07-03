BirdLibrary::Application.routes.draw do

  resources :birds, :only => [:index, :create, :show, :destroy]
  root :to => 'application#raise_not_found!'

  match '*unmatched_route', :to => 'application#raise_not_found!'

end
