# test/test_bonzi_cep.rb

require 'minitest/autorun'
require 'bonzi_cep'

class TestBonziCEP < Minitest::Test
  def test_valido?
    assert BonziCEP.valido?('12345-678')
    assert BonziCEP.valido?('12345678')
    refute BonziCEP.valido?('1234-5678')
    refute BonziCEP.valido?('123456789')
    refute BonziCEP.valido?('ABCDE-FGH')
  end

  def test_gerar
    cep = BonziCEP.gerar
    assert_match /\A\d{5}-\d{3}\z/, cep[:cep]
    assert BonziCEP.estados_suportados.include?(cep[:estado])
    assert BonziCEP.regioes_suportadas.include?(cep[:regiao])
  end

  def test_gerar_para_estado
    cep = BonziCEP.gerar_para_estado('SP')
    assert_equal 'SP', cep[:estado]
    assert_equal 'Sudeste', cep[:regiao]
    
    assert_raises(BonziCEP::EstadoInvalido) do
      BonziCEP.gerar_para_estado('XX')
    end
  end

  def test_consultar
    dados = BonziCEP.consultar('01001-000')
    assert_equal '01001-000', dados[:cep]
    assert_equal 'SP', dados[:estado]
    assert_equal 'Sudeste', dados[:regiao]
    
    assert_raises(BonziCEP::CEPInvalido) do
      BonziCEP.consultar('1234-567')
    end
  end

  def test_pertence_a_estado?
    assert BonziCEP.pertence_a_estado?('20000-000', 'RJ')
    refute BonziCEP.pertence_a_estado?('20000-000', 'SP')
    
    assert_raises(BonziCEP::EstadoInvalido) do
      BonziCEP.pertence_a_estado?('20000-000', 'XX')
    end
  end
end