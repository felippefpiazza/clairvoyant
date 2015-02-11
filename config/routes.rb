Rails.application.routes.draw do
  
  #resources :people
  namespace :admin do
    
    get '/' => 'user#login'
    get 'user/login' => 'user#login'
    get 'user/index' => 'user#index'
    post 'user/index' => 'user#index'
    get 'user/new' => 'user#new'
    post 'user/save' => 'user#save'
    get 'user/delete' => 'user#destroy'
    get 'user/:id' => 'user#show'

    get 'client/login' => 'client#login'
    get 'client/index' => 'client#index'
    post 'client/index' => 'client#index'
    get 'client/new' => 'client#new'
    post 'client/save' => 'client#save'
    get 'client/delete' => 'client#destroy'
    get 'client/:id' => 'client#show'

    get 'clairvoyant/login' => 'clairvoyant#login'
    get 'clairvoyant/index' => 'clairvoyant#index'
    post 'clairvoyant/index' => 'clairvoyant#index'
    get 'clairvoyant/new' => 'clairvoyant#new'
    post 'clairvoyant/save' => 'clairvoyant#save'
    get 'clairvoyant/delete' => 'clairvoyant#destroy'
    get 'clairvoyant/:id' => 'clairvoyant#show'

    get 'device/login' => 'device#login'
    get 'device/index' => 'device#index'
    post 'device/index' => 'device#index'
    get 'device/new' => 'device#new'
    post 'device/save' => 'device#save'
    get 'device/delete' => 'device#destroy'
    get 'device/:id' => 'device#show'

    get 'equipment/login' => 'equipment#login'
    get 'equipment/index' => 'equipment#index'
    post 'equipment/index' => 'equipment#index'
    get 'equipment/new' => 'equipment#new'
    post 'equipment/save' => 'equipment#save'
    get 'equipment/delete' => 'equipment#destroy'
    get 'equipment/:id' => 'equipment#show'

    get 'manufacturer/login' => 'manufacturer#login'
    get 'manufacturer/index' => 'manufacturer#index'
    post 'manufacturer/index' => 'manufacturer#index'
    get 'manufacturer/new' => 'manufacturer#new'
    post 'manufacturer/save' => 'manufacturer#save'
    get 'manufacturer/delete' => 'manufacturer#destroy'
    get 'manufacturer/:id' => 'manufacturer#show'
    
    get 'dashboard/index' => 'dashboard#index'
    
  end 
  
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
    get 'all_clairvoyants' => 'clairvoyant#all_clairvoyants', :default => {:format => 'xml'}
    post 'all_clairvoyants' => 'clairvoyant#all_clairvoyants', :default => {:format => 'xml'}    
    post 'clairvoyant_devices' => 'clairvoyant#clairvoyant_devices', :default => {:format => 'xml'}
    get 'clairvoyant_devices' => 'clairvoyant#clairvoyant_devices', :default => {:format => 'xml'}  
    post 'controller_data' => 'device#controller_data', :default => {:format => 'xml'}
    get 'controller_data' => 'device#controller_data', :default => {:format => 'xml'}    
    post 'canopen' => 'device#canopen', :default => {:format => 'xml'}
    get 'canopen' => 'device#canopen', :default => {:format => 'xml'}        
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
