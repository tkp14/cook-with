Rails.application.routes.draw do
  get 'static_pages/home'
  get 'static_pages/about'
  get 'static_pages/terms'
 root 'static_pages#home'
 get :about,        to: 'static_pages#about'
 get :use_of_terms, to: 'static_pages#terms'
end
