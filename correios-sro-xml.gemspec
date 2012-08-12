# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'correios/sro/version'

Gem::Specification.new do |gem|
  gem.name        = "correios-sro-xml"
  gem.version     = Correios::SRO::VERSION
  gem.authors     = ["Prodis a.k.a. Fernando Hamasaki"]
  gem.email       = ["prodis@gmail.com"]
  gem.summary     = "Sistema de Rastreamento de Objetos dos Correios (SRO)."
  gem.description = "Sistema de Rastreamento de Objetos dos Correios (SRO) utilizando o Web Service SRO XML, que permite a consulta de ate 50 encomendas simultaneamente."
  gem.homepage    = "http://github.com/prodis/correios-sro-xml"
  gem.licenses    = ["MIT"]

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.platform              = Gem::Platform::RUBY
  gem.required_ruby_version = Gem::Requirement.new(">= 1.8.7")

  gem.add_dependency "log-me",      "~> 0.0.4"
  gem.add_dependency "nokogiri",    "~> 1.5"
  gem.add_dependency "sax-machine", "~> 0.1"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec",   "~> 2.11"
  gem.add_development_dependency "fakeweb", "~> 1.3"
end
