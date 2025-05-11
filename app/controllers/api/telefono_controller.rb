module Api
class Api::TelefonoController < ActionController::API
  #skip_after_action :verify_authenticity_token

  def buscar
    numero = params[:numero].to_s.strip
    resultado = TelefonoService.buscar(numero)
    render json: resultado
  end
end
end
