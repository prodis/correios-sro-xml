# encoding: UTF-8
module Correios
  module SRO
    class Rastreador
      attr_accessor :usuario, :senha
      attr_accessor :tipo, :resultado
      attr_reader :objetos

      DEFAULT_OPTIONS = { :tipo => :lista, :resultado => :ultimo }

      def initialize(options = {})
        DEFAULT_OPTIONS.merge(options).each do |attr, value|
          self.send("#{attr}=", value)
        end

        yield self if block_given?
        @objetos = []
      end

      def consultar(*object_numbers)
        @objetos = object_numbers
        response = web_service.request(self)
        objects = parser.objetos(response)

        if objects.size == 1
          objects.values.first
        else
          objects
        end
      end

      private

      def web_service
        @web_service ||= Correios::SRO::WebService.new
      end

      def parser
        @parser ||= Correios::SRO::Parser.new
      end
    end
  end
end
