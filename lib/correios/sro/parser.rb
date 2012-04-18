# encoding: UTF-8
require 'nokogiri'

module Correios
  module SRO
    class Parser
      def objetos(xml)
        objetos = {}
        xml = xml.backward_encode("UTF-8", "ISO-8859-1")

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
