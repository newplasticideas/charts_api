Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #

  match '/get', to: "charts#get", via: :get
end
