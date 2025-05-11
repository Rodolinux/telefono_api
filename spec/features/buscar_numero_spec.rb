# spec/features/buscar_numero_spec.rb
require 'rails_helper'
require 'capybara/rspec'

RSpec.feature "Buscar números de teléfono", type: :feature do
  scenario "Usuario busca un número válido" do
    #get '/api/telefono/3515467426' # Simula una petición GET a tu endpoint
    post '/api/telefono', params: { numero: '3515467426' }
    expect(response).to have_http_status(200) # Verifica el código de respuesta
    expect(response.content_type).to eq('application/json; charset=utf-8')
    expect(JSON.parse(response.body)).to include('ciudad', 'provincia')

    expect(page).to have_content("Córdoba")

    expect(page).to have_content("351")
  end

  scenario "Usuario busca un número inválido" do
    #visit root_path
    post '/api/telefono', params: {numero: invalido}
    expect(response).to have_http_status(400) # Ejemplo de código de error
    expect(response.body).to include('Número inválido')
    expect(page).to have_content("No se encontró información")
  end
end