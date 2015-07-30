Rails.application.routes.draw do
  devise_for :users
  root 'homes#index'

  resources :userquestions, only: ["create"]
  resources :timedpractices, only: ["index", "create"]
  resources :benchsparks, only: ["index", "show", "update"] do
    member do
      get 'multiplication_master'
    end
  end
  resources :statistics, only: ["index", "show"]
  resources :practices, only: ["index"]
  resources :users, only: ["index", "update", "show"] do
    member do
      patch 'add_admin'
      patch 'remove_admin'
    end
  end
  resources :admins, only: ["index", "new"]
  resources :groups do
    member do
      get 'show_stats'
    end

  end
  resources :questions, only: ["update"] do
    member do
      get 'timedgame'
      patch 'correct'
      patch 'incorrect'
    end
  end



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
