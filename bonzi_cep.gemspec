# bonzi_cep.gemspec

require_relative "lib/bonzi_cep/version"

Gem::Specification.new do |spec|
  spec.name          = "bonzi_cep"
  spec.version       = BonziCEP::VERSION
  spec.authors       = ["sheran"]
  spec.email         = ["bonzibudddy@proton.me"]

  spec.summary       = "Ruby gem to generate, validate, and query Brazilian postal codes"
  spec.description   = "Ruby gem to generate, validate, and query Brazilian postal codes (CEP/zip code), including region, state, and description metadata."
  spec.homepage      = "https://github.com/sheranrafael/BonziCep"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # .
  spec.files         = Dir["lib/**/*.rb"] + Dir["exe/*"] + ["README.md"]
  spec.bindir        = "exe"
  spec.executables   = ["bonzi_cep"]
  spec.require_paths = ["lib"]

  # .
end
