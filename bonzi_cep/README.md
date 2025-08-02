# BonziCep 📍

Gem Ruby para gerar, validar e consultar códigos de endereçamento postal brasileiro (postal code/zip code), incluindo
metadados região, estado e descrição.  

---

## Características 

- ✅Zero dependências - Funciona com Ruby puro

- ✅Suporte a Ruby 3.1+ - Compatível com versões modernas

- ✅Interface simples - Fácil de usar tanto em código quanto via CLI

- ✅Dados embutidos - Não requer banco de dados ou API externa

---

## Funcionalidades

### Geração de CEPs

- Aleatórios ou por estado específico

- Com ou sem formatação (12345-678 ou 12345678)

- Inclui metadados automáticos (estado e região)

### Validação

- Verifica formato válido de CEP

- Checa se pertence a um estado específico

### Consulta

- Identifica estado e região de um CEP

- Suporte a todos os estados brasileiros

---

## Instalação:
Adicione ao seu Gemfile:

```ruby
gem 'bonzi_cep'
```

e execute
```bash
$ bundle install
```

ou instale diretamente
```bash
$ gem install bonzi_cep
```

## Uso
```ruby
require 'bonzi_cep'

# Gerar CEP aleatório
BonziCEP.gerar
#=> { cep: "12345-678", estado: "SP", regiao: "Sudeste" }

# Gerar para um estado específico
BonziCEP.gerar_para_estado('RJ')
#=> { cep: "20000-000", estado: "RJ", regiao: "Sudeste" }

# Validar CEP
BonziCEP.valido?("12345-678") #=> true

# Consultar CEP
BonziCEP.consultar("01001-000")
#=> { cep: "01001-000", estado: "SP", regiao: "Sudeste" }

# Verificar estado
BonziCEP.pertence_a_estado?("20000-000", "RJ") #=> true

# Listar estados suportados
BonziCEP.estados_suportados
#=> ["AC", "AL", "AM", ...]
```

Via terminal (CLI)
```ruby
# Gerar CEP aleatório
bonzi_cep -g

# Gerar para São Paulo
bonzi_cep -g -e SP

# Consultar um CEP
bonzi_cep -c 01001-000

# Validar um CEP
bonzi_cep -v 12345-678

# Listar estados suportados
bonzi_cep -l
```

## Licença
Este projeto está licenciado sob a licença MIT - veja o arquivo LICENSE para detalhes.
