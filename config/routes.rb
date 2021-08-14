Rails.application.routes.draw do
  get 'cards/top' => 'cards#top'
  post 'cards/submit' => 'cards#submit' 
  get 'cards/judge' => 'cards#judge' 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
