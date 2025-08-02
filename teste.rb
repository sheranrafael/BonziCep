# teste.rb
require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'bonzi_cep', path: '.' # Usa a gem local
end

require 'bonzi_cep'

puts "\n=== Testando BonziCEP ==="

# Teste 1: Gerar CEP aleatório
puts "\n1. Gerar CEP aleatório:"
cep_aleatorio = BonziCEP.gerar
puts cep_aleatorio

# Teste 2: Gerar para estado específico (SP)
puts "\n2. Gerar CEP para SP:"
cep_sp = BonziCEP.gerar_para_estado('SP')
puts cep_sp

# Teste 3: Consultar CEP
puts "\n3. Consultar CEP 01001-000:"
begin
  consulta = BonziCEP.consultar('01001-000')
  puts consulta
rescue BonziCEP::CEPInvalido => e
  puts "Erro: #{e.message}"
end

# Teste 4: Validar CEP
puts "\n4. Validação de CEP:"
puts "'12345-678' é válido? #{BonziCEP.valido?('12345-678')}"
puts "'1234-5678' é válido? #{BonziCEP.valido?('1234-5678')}"

# Teste 5: Verificar estado
puts "\n5. Pertence a RJ?:"
puts "'20000-000' pertence a RJ? #{BonziCEP.pertence_a_estado?('20000-000', 'RJ')}"

puts "\n=== Teste concluído ==="