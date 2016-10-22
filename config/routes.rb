Rails.application.routes.draw do
	root to: 'articles#index'
	resources :articles do
		resources :comments
	end
	resources :tags

	resources :authors

	resources :author_sessions, only: [ :new, :create, :destroy ]

	get 'login'  => 'author_sessions#new'
	get 'logout' => 'author_sessions#destroy'

	#get 'articles/year/' => 'articles#years', as: :years
	get 'articles/year/:year' => 'articles#year', as: :year
	get 'articles/year/:year/:month' => 'articles#month', as: :month

	get 'feed' => 'articles#feed', as: :rss

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
