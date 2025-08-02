# BonziCep

Gem Ruby para gerar, validar e consultar códigos de endereçamento postal brasileiro (postal code/zip code), incluindo
metadados região, estado e descrição.  

---

## Características 

- Zero dependências - Funciona com Ruby puro

- Suporte a Ruby 3.1+ - Compatível com versões modernas

- Interface simples - Fácil de usar tanto em código quanto via CLI

- Dados embutidos - Não requer banco de dados ou API externa

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
bundle install
```

ou instale diretamente
```bash
gem install bonzi_cep
```


