require 'sax-machine'

module Correios
  module SRO
    class Object
      include SAXMachine

      element  :numero, :as => :number
      element  :erro,   :as => :error
      elements :evento, :as => :events, :class => Correios::SRO::Event

      def has_error?
        error != nil
      end

    end
  end
end
