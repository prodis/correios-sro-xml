# encoding: UTF-8
require 'net/http'
require 'uri'

module Correios
  module SRO
    class WebService
      URL = "http://websro.correios.com.br/sro_bin/sroii_xml.eventos"
      TYPES = { :lista => "L", :intervalo => "F" }
      RESULTS = { :todos => "T", :ultimo => "U" }

      def initialize
        @uri = URI.parse(URL)
      end

      def request(sro)
        response = Net::HTTP.post_form(@uri, params_for(sro))
        response.body.encode("UTF-8", "ISO-8859-1")
      end

      private

      def params_for(sro)
        {
          :Usuario => sro.usuario,
          :Senha => sro.senha,
          :Tipo => TYPES[sro.tipo],
          :Resultado => RESULTS[sro.resultado],
          :Objetos => sro.objetos.join
        }
      end
    end
  end
end
