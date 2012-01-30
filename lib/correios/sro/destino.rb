# encoding: UTF-8
require 'sax-machine'

module Correios
  module SRO
    class Destino
      include SAXMachine

      element :local
      element :codigo
      element :cidade
      element :bairro
      element :uf
    end
  end
end
