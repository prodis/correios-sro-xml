# encoding: UTF-8
module Correios
  module SRO
    class Rastreador
      attr_accessor :usuario, :senha
      attr_accessor :tipo, :resultado

      DEFAULT_OPTIONS = { :tipo => :lista, :resultado => :ultimo }

      def initialize(options = {})
        DEFAULT_OPTIONS.merge(options).each do |attr, value|
          self.send("#{attr}=", value)
        end

        yield self if block_given?
      end

      def consultar(*objetos)
      end
    end
  end
end
