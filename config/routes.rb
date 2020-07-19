Rails.application.routes.draw do
  resources :snippets
  resources :snippets do
    resources :snippets
    resources :comments
    member do
      put 'vote', to: "snippets#like"
      put 'unvote', to: "snippets#unlike"
      put 'outdated', to: "snippets#like"
      put 'notoutdated', to: "snippets#unlike"
    end
  end

  post 'flag/:id', to: 'snippets#flag', as: 'flag_snippet'
  
  devise_for :users, controllers: {registrations: 'registrations'}
  root 'snippets#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
