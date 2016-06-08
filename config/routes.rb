RedmineApp::Application.routes.draw do
  resources :projects do
  	resources :proteus
  end
  # match "/proteus/:project_id", controller: "proteus", :action => "index", :via => :get #, :collection => { :create => :post }
  # map.resources :proteus
  # map.connect 'projects/:project_id/changes/:action', :controller => 'proteus'
  #get '/projects/:project_id/proteus', to: 'proteus#index'
  #get '/projects/:project_id/proteus/new', to: 'proteus#new'
  #post '/projects/:project_id/proteus/create', to: 'proteus#create'
  #get '/projects/:project_id/proteus/:id', to: 'proteus#show'
  #get '/projects/:project_id/proteus/:id/edit', to: 'proteus#edit'
  #put '/projects/:project_id/proteus/:id', to: 'proteus#update'
  #delete '/projects/:project_id/proteus/:id', to: 'proteus#destroy'
end
