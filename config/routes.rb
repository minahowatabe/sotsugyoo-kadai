Rails.application.routes.draw do
  root to: "plans#top"
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
   devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  
  # devise_scope :user do
  #   get "sign_in", :to => "users/sessions#new"
  #   get "sign_out", :to => "users/sessions#destroy" 
  # end
  
  resources :plans do
    collection do
      post :confirm
    end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 end
end
