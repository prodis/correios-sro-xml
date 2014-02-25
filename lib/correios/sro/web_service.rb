require 'net/http'
require 'uri'

module Correios
  module SRO
    class WebService
      URL = "http://websro.correios.com.br/sro_bin/sroii_xml.eventos"
      QUERY_TYPES =  { list: "L", range: "F" }
      RESULT_MODES = { all:  "T", last:  "U" }

      def initialize(tracker)
        @uri = URI.parse(URL)
        @tracker = tracker
      end

      def request!
        http = build_http

        request = build_request
        Correios::SRO.log_request request, @uri.to_s

        response = http.request(request)
        Correios::SRO.log_response response

        response.body
      end

      private

      def build_http
        http = Net::HTTP.new(@uri.host, @uri.port)
        http.open_timeout = Correios::SRO.request_timeout
        http
      end

      def build_request
        request = Net::HTTP::Post.new(@uri.path)
        request.set_form_data(request_params)
        request
      end

      def request_params
        {
          Usuario: @tracker.user,
          Senha: @tracker.password,
          Tipo: QUERY_TYPES[@tracker.query_type],
          Resultado: RESULT_MODES[@tracker.result_mode],
          Objetos: @tracker.object_numbers.join
        }
      end
    end
  end
end
