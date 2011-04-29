Intr::Application.routes.draw do
  root :to => 'welcome#index'
  get '/dashboard', :to => 'welcome#dashboard'
end
