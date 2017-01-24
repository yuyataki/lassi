Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'pages#index'
  get 'pages/show'

  get 'mypage' => 'mypage#index'

  resources :question_sets, only: :show
  post 'question_sets/:id/yourresult' => 'question_sets#yourresult'

  namespace 'mypage' do
    resources :question_sets, only: %i(create show update destroy)
    get 'question_sets/:id/histories' => 'question_sets#histories'
    resources :questions do
      resources :question_scores
    end
    resources :favorites, only: :index
    post 'create_scores' => 'questions#create_scores'
  end

  namespace 'api' do
    namespace 'v1' do
      get 'parties' => 'parties#parties'
    end
  end

  get '/404' => 'errors#render_404'
  get '/500' => 'errors#render_500'
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