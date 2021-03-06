Rails.application.routes.draw do
  resources :attachments
  resources :spaces do
    resources :reviews, only: [:index, :new, :create]
    resources :bookings, only: [:new, :create]
  end
  resources :vehicles, except: [:new, :show]
  resources :bookings, only: [:index, :destroy]
  resources :proposals, only: [:index] do
    get 'aprove', on: :member
    get 'reject', on: :member
    get 'accept', on: :member
  end
  resources :locations, only: [:index]
  resources :favorites, only: [:index, :destroy, :create]
  devise_for :users
  resources :users, only: [:show]
  get 'spaces/last_bookings_accepted/:id', to: 'spaces#last_bookings_accepted', as: 'last_bookings_accepted'
  get 'static_pages/help'
  get 'static_pages/faq'
  get 'static_pages/dashboard'
  root 'static_pages#home'

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
