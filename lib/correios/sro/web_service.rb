# encoding: UTF-8
require 'net/http'
require 'uri'

module Correios
  module SRO
    class WebService
      URL = "http://websro.correios.com.br/sro_bin/sroii_xml.eventos"
      RESULT_TYPES = { :list => "L", :interval => "F" }
      RESULT_MODES = { :all => "T", :last => "U" }

      def initialize
        @uri = URI.parse(URL)
      end

      def request(tracker)
        response = Net::HTTP.post_form(@uri, params_for(tracker))
        response.body
      end

      private

      def params_for(tracker)
        {
          :Usuario => tracker.user,
          :Senha => tracker.password,
          :Tipo => RESULT_TYPES[tracker.result_type],
          :Resultado => RESULT_MODES[tracker.result_mode],
          :Objetos => tracker.object_numbers.join
        }
      end
    end
  end
end
