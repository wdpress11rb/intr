Intr::Application.routes.draw do
  root :to => 'welcome#index'
  get '/dashboard', :to => 'welcome#dashboard'
  post '/introduce', :to => 'welcome#introduce'

  delete 'sessions/destroy'
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'
end
