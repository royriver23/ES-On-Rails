Rails.application.routes.draw do
  resources :teams do
    resources :employees, only: %i(create index)
  end
  resources :employees, except: %i(create index)
end
