# encoding: UTF-8
require 'sax-machine'

module Correios
  module SRO
    class Event
      include SAXMachine

      element :tipo,       :as => :type
      element :status,     :as => :status
      element :data,       :as => :date
      element :hora,       :as => :hour
      element :descricao,  :as => :description
      element :recebedor,  :as => :receiver
      element :documento,  :as => :document
      element :comentario, :as => :comment
      element :local,      :as => :place
      element :codigo,     :as => :code
      element :cidade,     :as => :city
      element :uf,         :as => :state
      element :sto,        :as => :sto
      element :destino,    :as => :destination, :class => Correios::SRO::Destination

      [:receiver, :document, :comment].each do |method|
        define_method "#{method}=" do |value|
          instance_variable_set("@#{method}", value.to_s.strip)
        end
      end
    end
  end
end
