Rails.application.routes.draw do
  resources :matches, param: :uuid
end
