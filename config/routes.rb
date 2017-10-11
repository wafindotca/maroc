Rails.application.routes.draw do
  resources :vistors do
  	collection do
      get :signout_vistor
      get :search_visitor
      get :search_by_user_type
      get :generate_reports
      get :search_by_date
      post :calender_search_record
    end
  end
  get 'welcome/index'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
