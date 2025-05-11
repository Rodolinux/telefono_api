class TelefonoService
  CODIGOS_ARGENTINA = {
    '11' => { ciudad: 'Buenos Aires', provincia: 'Buenos Aires' },
    '223' => { ciudad: 'Mar del Plata', provincia: 'Buenos Aires' },
    '221' => { ciudad: 'La Plata', provincia: 'Buenos Aires' },
    '239' => { ciudad: 'Bahía Blanca', provincia: 'Buenos Aires' },
    '291' => { ciudad: 'Bahía Blanca', provincia: 'Buenos Aires' },
    '261' => { ciudad: 'Mendoza', provincia: 'Mendoza' },
    '351' => { ciudad: 'Córdoba', provincia: 'Córdoba' },
    '381' => { ciudad: 'San Miguel de Tucumán', provincia: 'Tucumán' },
    '341' => { ciudad: 'Rosario', provincia: 'Santa Fe' },
    '343' => { ciudad: 'Paraná', provincia: 'Entre Ríos' },
    '379' => { ciudad: 'Corrientes', provincia: 'Corrientes' },
    '388' => { ciudad: 'San Juan', provincia: 'San Juan' },

    # Agrega más según necesites
  }.freeze
  def self.buscar(numero)
    numero_limpio = numero.gsub(/^(\+54|0)?/, '')
    codigo = CODIGOS_ARGENTINA.keys.find {|c| numero_limpio.start_with?(c) }
    if codigo
      {
        numero: numero,
        codigo_area: codigo,
        ciudad: CODIGOS_ARGENTINA[codigo][:ciudad],
        provincia: CODIGOS_ARGENTINA[codigo][:provincia]
      }
    else
      {
        error: "No se encontró el código de área para #{numero}"
      }
    end
  end
end

