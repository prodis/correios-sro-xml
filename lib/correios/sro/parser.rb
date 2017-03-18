require 'nokogiri'

module Correios
  module SRO
    class Parser
      def objects(xml)
        objects = {}

        Nokogiri::XML(xml).xpath("//objeto").each do |element|
          object = Correios::SRO::Object.parse(element.to_xml)
          objects[object.number] = object unless object.has_error?
        end

        objects
      end
    end
  end
end
