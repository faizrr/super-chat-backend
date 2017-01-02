Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  get 'profile', to: 'users#profile'
end
