require 'net/http'
require 'uri'

module Correios
  module SRO
    class WebService
      URL = "http://webservice.correios.com.br:80/service/rastro"

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

        response.body.force_encoding('utf-8')
      end

      private

      def build_http
        http = Net::HTTP.new(@uri.host, @uri.port)
        http.open_timeout = Correios::SRO.request_timeout
        http
      end

      def build_request
        request = Net::HTTP::Post.new(@uri.path)
        request.content_type = 'text/xml;charset=UTF-8'
        request.add_field("Accept-Encoding", "UTF-8")
        request.body = request_body
        request
      end

      def request_body
        RequestBuilder.new(@tracker).build_xml
      end
    end
  end
end
