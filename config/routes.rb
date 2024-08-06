Rails.application.routes.draw do

  resources :defects do
    resources :photos, only: [:create, :destroy] do 
      collection do
        post :create             #-> domain.com/assignments/:id/create
        post :create_general     #-> domain.com/assignments/:id/create
        post :create_before    
        post :create_after    
        post :insert           
      end
      member do
        put  :switch_printable     #-> domain.com/orders/:id/delete+photo
      end
    end
  end
  resources :business_staffs
  resources :bookings
  get 'host_calendar' => 'calendars#host' 
  get 'assignment_calendar' => 'calendars#assignment'
  get 'headless_home' => 'home#headless'
  get 'help' => 'home#help'

  resources :rooms
  resources :duties
  resources :calls
  resources :guardians
  resources :announcements
  get 'announcements/:id/hide', to: 'announcements#hide', as: 'hide_announcement'

  resources :conversations, only: [:index, :create]  do
    resources :lines, only: [:index, :create]
  end

  resources :assignments do 
    collection { post :import }
    resource :download, only: [:show] 
    member do
        put :start            #-> assignements/:id/start 
        put :assign           #-> assignements/:id/finish
        put :quote            #-> assignements/:id/finish
        put :finish           #-> assignements/:id/finish
        put :accept           #-> assignements/:id/accept
        put :reject           #-> assignements/:id/reject
        put :acknowledge      #-> assignements/:id/acknowledge
        put :complete         #-> assignements/:id/complete 
      end
    resources :photos, only: [:create, :destroy] do 
      collection do
        post :create             #-> domain.com/assignments/:id/create
        post :create_general     #-> domain.com/assignments/:id/create
        post :create_before    
        post :create_after    
        post :insert           
      end
      member do
        put  :switch_printable     #-> domain.com/orders/:id/delete+photo
      end
    end
  end
  resources :workflows
  resources :locations do
    collection { post :import }
  end

  resources :masters do
    collection { post :import }
  end
  devise_for :users
  resources :users
    resources :orders do 
      collection do 
        get :open
      end
  end

  resources :chatrooms do
    resource :chatroom_users
    resources :messages
  end
 
  resources :direct_messages

  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'

  #authenticated :user do
  #  root 'dashboard#index', as: :authenticated_root
  #end
  root to: "home#tc"
  #root to: 'dashboards#index'

  get 'dashboard', to: 'dashboards#index'
  get '/notifications', to: 'notifications#index'

  # mount Sidekiq::Web, at: '/sidekiq'

  mount ActionCable.server => '/cable'

  # Service Worker Routes
  get '/service-worker.js' => "service_worker#service_worker"
  get '/manifest.json' => "service_worker#manifest"

end
