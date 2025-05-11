Rails.application.routes.draw do

  get '/api/telefono/:numero', to: 'api/telefono#buscar', as: :api_telefono_buscar
  get "up" => "rails/health#show", as: :rails_health_check


end
