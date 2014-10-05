Rails.application.routes.draw do
  
  #resources :people
  namespace :api do
    resource :user, :default => {:format => 'xml'}
    get 'user/auth' => 'user#auth', :default => {:format => 'xml'}
    post 'user/auth' => 'user#auth', :default => {:format => 'xml'}
    post 'user/create_user' => 'user#create_user', :default => {:format => 'xml'}    
    get 'user/nothing' => 'user#nothing', :default => {:format => 'xml'}
    post 'add_address' => 'address#add_address', :default => {:format => 'xml'}
    post 'create_device' => 'device#create_device', :default => {:format => 'xml'}
    post 'create_clairvoyant' => 'clairvoyant#create_clairvoyant', :default => {:format => 'xml'}    
    post 'send_params' => 'device#send_params', :default => {:format => 'xml'}    
    post 'send_faults' => 'device#send_faults', :default => {:format => 'xml'} 
    post 'destroy_all' => 'device#destroy_all', :default => {:format => 'xml'}    
    get 'destroy_all' => 'device#destroy_all', :default => {:format => 'xml'}    
    post 'get_address' => 'address#get_address', :default => {:format => 'xml'}
    post 'get_user' => 'user#get_user', :default => {:format => 'xml'}

  end  
  #resource :user, :default => {:format => 'xml'}
  #get 'user/' => 'user#index'
  #post 'user/' => 'user#index'
  
  #map.resources :people, :has_many => :addresses
  
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
