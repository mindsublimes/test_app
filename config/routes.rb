Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :news_letters
    root to: "news_letters#new"
    resources :news_letters do
    collection do
      post "change_language"
    end
  end
end
