# encoding: UTF-8
require 'sax-machine'

module Correios
  module SRO
    class Object
      include SAXMachine

      element  :numero, :as => :number
      elements :evento, :as => :events, :class => Correios::SRO::Event
    end
  end
end
