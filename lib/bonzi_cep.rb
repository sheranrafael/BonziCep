# lib/bonzi_cep.rb

require "bonzi_cep/version"

module BonziCEP
  class Error < StandardError; end
  class EstadoInvalido < Error; end
  class CEPInvalido < Error; end

  # Prefixos de CEP por estado (primeiros dígitos)
  ESTADOS_POR_PREFIXO = {
    'SP' => [*1..9, 10, 11, 12].freeze,
    'RJ' => [20, 21, 22, 23, 24].freeze,
    'ES' => [29].freeze,
    'MG' => [*30..39].freeze,
    'BA' => [*40..48].freeze,
    'SE' => [49].freeze,
    'PE' => [*50..56].freeze,
    'AL' => [57].freeze,
    'PB' => [58].freeze,
    'RN' => [59].freeze,
    'CE' => [*60..63, 64].freeze,
    'PI' => [64].freeze,
    'MA' => [65].freeze,
    'PA' => [*66..68].freeze,
    'AP' => [68].freeze,
    'AM' => [69].freeze,
    'RR' => [69].freeze,
    'AC' => [69].freeze,
    'DF' => [70, 71, 72, *73..74].freeze,
    'GO' => [72, *73..76].freeze,
    'TO' => [77].freeze,
    'MT' => [78].freeze,
    'MS' => [79].freeze,
    'RO' => [76].freeze,
    'PR' => [*80..87].freeze,
    'SC' => [*88..89].freeze,
    'RS' => [*90..99].freeze
  }.freeze

  # Regiões por estado
  REGIOES_POR_ESTADO = {
    'AC' => 'Norte',    'AL' => 'Nordeste', 'AP' => 'Norte',
    'AM' => 'Norte',    'BA' => 'Nordeste', 'CE' => 'Nordeste',
    'DF' => 'Centro-Oeste', 'ES' => 'Sudeste', 'GO' => 'Centro-Oeste',
    'MA' => 'Nordeste', 'MT' => 'Centro-Oeste', 'MS' => 'Centro-Oeste',
    'MG' => 'Sudeste',  'PA' => 'Norte',    'PB' => 'Nordeste',
    'PR' => 'Sul',      'PE' => 'Nordeste', 'PI' => 'Nordeste',
    'RJ' => 'Sudeste',  'RN' => 'Nordeste', 'RS' => 'Sul',
    'RO' => 'Norte',    'RR' => 'Norte',    'SC' => 'Sul',
    'SP' => 'Sudeste',  'SE' => 'Nordeste', 'TO' => 'Norte'
  }.freeze

  class << self
    CEP_REGEX = /\A\d{5}-?\d{3}\z/

    # Gera um CEP aleatório
    def gerar(formato: true, estado: nil)
      estado = estado.to_s.upcase if estado
      
      prefixos = if estado && ESTADOS_POR_PREFIXO.key?(estado)
                  ESTADOS_POR_PREFIXO[estado]
                 else
                  ESTADOS_POR_PREFIXO.values.flatten
                 end

      prefixo = prefixos.sample.to_s.rjust(2, '0')
      sufixo = rand(100..999).to_s
      cep_numero = "#{prefixo}#{rand(100..999)}#{sufixo}"

      estado ||= encontrar_estado_por_prefixo(prefixo.to_i)

      {
        cep: formatar_cep(cep_numero, formato),
        estado: estado,
        regiao: REGIOES_POR_ESTADO[estado]
      }
    end

    # Gera CEP para um estado específico
    def gerar_para_estado(estado, formato: true)
      estado = estado.to_s.upcase
      raise EstadoInvalido, "Estado inválido" unless ESTADOS_POR_PREFIXO.key?(estado)
      
      gerar(formato: formato, estado: estado)
    end

    # Valida formato do CEP
    def valido?(cep)
      cep.to_s.match?(CEP_REGEX)
    end

    # Verifica se CEP pertence a um estado
    def pertence_a_estado?(cep, estado)
      estado = estado.to_s.upcase
      raise EstadoInvalido, "Estado inválido" unless ESTADOS_POR_PREFIXO.key?(estado)
      
      cep_normalizado = normalizar_cep(cep)
      return false unless valido?(cep_normalizado)

      prefixo = cep_normalizado[0..1].to_i
      ESTADOS_POR_PREFIXO[estado].include?(prefixo)
    end

    # Consulta informações do CEP
    def consultar(cep)
      cep_normalizado = normalizar_cep(cep)
      raise CEPInvalido, "CEP inválido" unless valido?(cep_normalizado)

      prefixo = cep_normalizado[0..1].to_i
      estado = encontrar_estado_por_prefixo(prefixo)
      raise CEPInvalido, "CEP não encontrado" unless estado

      {
        cep: formatar_cep(cep_normalizado, true),
        estado: estado,
        regiao: REGIOES_POR_ESTADO[estado]
      }
    end

    # Lista de estados suportados
    def estados_suportados
      ESTADOS_POR_PREFIXO.keys.sort
    end

    # Lista de regiões suportadas
    def regioes_suportadas
      REGIOES_POR_ESTADO.values.uniq.sort
    end

    private

    def normalizar_cep(cep)
      cep.to_s.gsub(/[^0-9]/, '')
    end

    def formatar_cep(cep, formato)
      cep_normalizado = normalizar_cep(cep)
      formato ? "#{cep_normalizado[0..4]}-#{cep_normalizado[5..7]}" : cep_normalizado
    end

    def encontrar_estado_por_prefixo(prefixo)
      ESTADOS_POR_PREFIXO.each do |estado, prefixos|
        return estado if prefixos.include?(prefixo)
      end
      nil
    end
  end
end