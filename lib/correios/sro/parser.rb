require 'nokogiri'

module Correios
  module SRO
    class Parser
      def objects(xml)
        objects = {}

        Nokogiri::XML(xml).xpath("//objeto").each do |element|
          object = Correios::SRO::Object.parse(element.to_xml)
          return objects if object.has_error?
          objects[object.number] = object
        end

        objects
      end
    end
  end
end
