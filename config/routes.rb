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

 match '/(:state)(/:city)(/:category)(/:id)/get_new_captcha' => 'ads#get_new_captcha', :as => :ad_new_captcha

  match '/(:state)(/:city)(/:category)(/:id)/verify_name' => 'ads#verify_name', :as => :ad_verify_name
  match '/(:state)(/:city)(/:category)(/:id)/verify_email' => 'ads#verify_email', :as => :ad_verify_email
  match '/(:state)(/:city)(/:category)(/:id)/verify_phone_number' => 'ads#verify_phone_number', :as => :ad_verify_phone_number
  match '/(:state)(/:city)(/:category)(/:id)/verify_subject' => 'ads#verify_subject', :as => :ad_verify_subject
  match '/(:state)(/:city)(/:category)(/:id)/verify_message' => 'ads#verify_message', :as => :ad_verify_message
  match '/(:state)(/:city)(/:category)(/:id)/verify_captcha' => 'ads#verify_captcha', :as => :ad_verify_captcha
  match '/(:state)(/:city)(/:category)(/:id)/verify_for_emptiness' => 'ads#verify_for_emptiness', :as => :ad_verify_for_emptiness

  resources :ads

 resources :categories

  resources :images

  resources :details

 match "export_categories" => "categories#export_categories"
 match "export_products" => "categories#export_products"

   root :to => 'categories#home'

devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
#match '/ad/new' => 'ads#new', :as => :new_ad

  match '/(:state)(/:city)(/:category)(/:id)/' => 'ads#show', :as => :ad

end
