Rails.application.routes.draw do
  get 'game' => 'playing#game'
  get 'score' => 'playing#score'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
