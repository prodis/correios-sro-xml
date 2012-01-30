# encoding: UTF-8
require 'sax-machine'

module Correios
  module SRO
    class Evento
      include SAXMachine

      element :tipo
      element :status
      element :data
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
    end
  end
end
