require 'sax-machine'

module Correios
  module SRO
    class Destination
      include SAXMachine

      element :local,  :as => :place
      element :codigo, :as => :code
      element :cidade, :as => :city
      element :bairro, :as => :neighborhood
      element :uf,     :as => :state
    end
  end
end
