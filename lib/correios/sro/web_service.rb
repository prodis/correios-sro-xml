# encoding: UTF-8
require 'net/http'
require 'uri'

module Correios
  module SRO
    class WebService
      URL = "http://websro.correios.com.br/sro_bin/sroii_xml.eventos"
      RESULT_TYPES = { :list => "L", :interval => "F" }
      RESULT_MODES = { :all => "T", :last => "U" }

      def initialize(tracker)
        @uri = URI.parse(URL)
        @tracker = tracker
      end

      def request!
        http = build_http

        request = build_request
        log_request(request)

        response = http.request(request)
        log_response(response)

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
          :Usuario => @tracker.user,
          :Senha => @tracker.password,
          :Tipo => RESULT_TYPES[@tracker.result_type],
          :Resultado => RESULT_MODES[@tracker.result_mode],
          :Objetos => @tracker.object_numbers.join
        }
      end

      def log_request(request)
        message = format_message(request) do
          message =  with_line_break { "Correios-SRO-XML Request:" }
          message << with_line_break { "POST #{URL}" }
        end

        Correios::SRO.log(message)
      end

      def log_response(response)
        message = format_message(response) do
          message =  with_line_break { "Correios-SRO-XML Response:" }
          message << with_line_break { "HTTP/#{response.http_version} #{response.code} #{response.message}" }
        end

        Correios::SRO.log(message)
      end

      def format_message(http)
        message = yield
        message << with_line_break { format_headers_for(http) } if Correios::SRO.log_level == :debug
        message << with_line_break { http.body }
      end

      def format_headers_for(http)
        # I'm using an empty block in each_header method for Ruby 1.8.7 compatibility.
        http.each_header{}.map { |name, values| "#{name}: #{values.first}" }.join("\n")
      end

      def with_line_break
        "#{yield}\n"
      end
    end
  end
end
