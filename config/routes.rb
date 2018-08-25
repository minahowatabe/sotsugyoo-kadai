Rails.application.routes.draw do
  root to: "plans#top"
  
  # post 'comments/create', to: 'comment#create', as: :comment_create
  resources :comments
  
   devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  
  resources :favorites 
  
  resources :plans do
    
    collection do
      post :confirm
    end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end


