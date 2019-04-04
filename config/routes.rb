Rails.application.routes.draw do
	root 'home#index'
	resources :users
	namespace :home do
		get 'licitacao'
		post 'treat_file'
	end
end