Rails.application.routes.draw do
  resources :cart_items do    
    delete 'truncate', on: :collection
  end
  resources :users do
       get 'getUserByEmail', on: :collection
  end
  resources :money_bags do
       get 'getBagId', on: :collection
  end
  resources :data_analytics do  
    get 'get_analytics_data', on: :collection
    get 'getItemsByUserId', on: :collection
  end  
  resources :orders    
  resources :product_categories do
       get 'show_sub_category', on: :member
  end
  resources :products do
  	   get 'show_products', on: :member
       put 'update_quantity', on: :member
  end
  resources :order_items do
      post 'create_bulk', on: :collection
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
