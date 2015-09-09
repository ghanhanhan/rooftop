Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  root :to => "home#index"
  
  match "/home", :to => "home#index", :via => [:get, :post]
  match "/mypage", :to => "mypage#index", :via => [:get, :post]
  match "/:username", :to => "mypage#page", :via => [:get, :post]
  match "/profile", :to => "mypage#profile", :via => [:get, :post]
  
  get  ":controller(/:action(/:id))"
  post ":controller(/:action(/:id))"
 

  
end