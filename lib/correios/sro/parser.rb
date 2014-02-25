require 'nokogiri'

module Correios
  module SRO
    class Parser
      def objects(xml)
        objects = {}
        xml = xml.backward_encode("UTF-8", "ISO-8859-1")

        doc = Nokogiri::XML(xml)
        doc.xpath("//objeto").each do |element|
          object = Correios::SRO::Object.parse(element.to_xml)
          objects[object.number] = object
        end

        objects
      end
    end
  end
end
