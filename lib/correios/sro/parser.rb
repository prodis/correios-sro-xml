# encoding: UTF-8
require 'nokogiri'

module Correios
  module SRO
    class Parser
      def objetos(xml)
        objetos = {}

        doc = Nokogiri::XML(xml)
        doc.xpath("//objeto").each do |element|
          objeto = Correios::SRO::Objeto.parse(element.to_xml)
          objetos[objeto.numero] = objeto
        end

        objetos
      end
    end
  end
end
