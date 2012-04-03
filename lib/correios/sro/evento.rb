# encoding: UTF-8
require 'sax-machine'

module Correios
  module SRO
    class Evento
      include SAXMachine

      element :tipo
      element :status
      element :data
      element :hora
      element :descricao
      element :recebedor
      element :documento
      element :comentario
      element :local
      element :codigo
      element :cidade
      element :uf
      element :sto
      element :destino, :class => Correios::SRO::Destino

      [:recebedor, :documento, :comentario].each do |method|
        define_method "#{method}=" do |value|
          instance_variable_set("@#{method}", value.to_s.strip)
        end
      end
    end
  end
end
