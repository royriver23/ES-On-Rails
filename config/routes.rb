Rails.application.routes.draw do
  resources :teams do
    resources :employees, only: %i(create index), controller: 'teams/employees'
  end
  resources :employees, except: %i(create index)
end
