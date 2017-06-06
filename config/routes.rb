Rails.application.routes.draw do
  resources :teams do
    scope module: 'teams' do
      resources :employees, only: %i(create index)
    end
  end

  resources :employees, except: %i(create index) do
    scope module: 'employees' do
      resources :skills, only: :index
    end
  end

  # Don't do the API verbose longer than necessary
    # Bad:
  # resources :teams do
  #   resources :employees do
  #     resources :skills
  #   end
  # end
end
