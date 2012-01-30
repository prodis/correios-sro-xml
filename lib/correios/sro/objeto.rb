# encoding: UTF-8
require 'sax-machine'

module Correios
  module SRO
    class Objeto
      include SAXMachine

      element :numero
      elements :evento, :as => :eventos, :class => Correios::SRO::Evento
    end
  end
end
