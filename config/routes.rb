Jualo::Application.routes.draw do

  resources :spam_reports


  resources :abuse_reports


  resources :attach_tokens


  devise_for :users, :controllers => {:registrations => "registrations", :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :currencies


  resources :ads_variants


  resources :variants


  resources :options


  resources :options_variants


  resources :category_options


  resources :ad_types
  match "ads/send_email" => "ads#send_email", :as => :send_email

  resources :static_pages

   match "users/register" => "users#register"
  resources :users


  resources :states do

      resources :cities do

          resources :categories  do

          end

      end


  end

  resources :ads

 resources :categories

  resources :images


  resources :details









 match "export_categories" => "categories#export_categories"
 match "export_products" => "categories#export_products"


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => 'categories#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
#match '/ad/new' => 'ads#new', :as => :new_ad



  match '/(:state)(/:city)(/:category)(/:id)/' => 'ads#show', :as => :ad
  match '/(:state)(/:city)(/:category)(/:id)/get_new_captcha' => 'ads#get_new_captcha', :as => :ad_new_captcha

  match '/(:state)(/:city)(/:category)(/:id)/verify_name' => 'ads#verify_name', :as => :ad_verify_name
  match '/(:state)(/:city)(/:category)(/:id)/verify_email' => 'ads#verify_email', :as => :ad_verify_email
  match '/(:state)(/:city)(/:category)(/:id)/verify_phone_number' => 'ads#verify_phone_number', :as => :ad_verify_phone_number
  match '/(:state)(/:city)(/:category)(/:id)/verify_subject' => 'ads#verify_subject', :as => :ad_verify_subject
  match '/(:state)(/:city)(/:category)(/:id)/verify_message' => 'ads#verify_message', :as => :ad_verify_message
  match '/(:state)(/:city)(/:category)(/:id)/verify_captcha' => 'ads#verify_captcha', :as => :ad_verify_captcha
end
