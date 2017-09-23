Rails.application.routes.draw do
  	get 'players/new'
  	get '/teams', to: 'application#hello', as: 'team'
  	resources :players
	#root 'cgame#index'
	root 'application#hello' 
	get '/stats', to: 'cgame#index', as: 'stats'
	get '/other', to: 'cgame#other', as: 'other'
	get '/sort', to: 'cgame#sort', as: 'sort'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
