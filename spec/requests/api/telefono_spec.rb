# spec/requests/api/telefono_spec.rb
require 'rails_helper'

RSpec.describe "API de Teléfonos" do
  describe "GET /api/telefono/:numero" do
    let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json', 'HTTP_HOST' => 'www.test' } } # Añadimos HTTP_HOST

    it "retorna información válida para un número correcto" do
      numero_correcto = '3515467426'
      get "/api/telefono/#{numero_correcto}", headers: headers

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(JSON.parse(response.body)).to include('numero', 'codigo_area', 'ciudad', 'provincia')
      # ... tus otras expectativas ...
    end

    it 'maneja números inválidos' do
      numero_invalido = '9999999999' # Ejemplo de número sin código de área conocido
      get "/api/telefono/#{numero_invalido}", headers: headers

      expect(response).to have_http_status(200) # Debería devolver 200 incluso con error
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(JSON.parse(response.body)).to include('error')
      # ... tus otras expectativas ...
    end
  end
end