Rails.application.routes.draw do
  mount Messenger::Bot::Space => "/webhook"
  resources :userdatum
end
