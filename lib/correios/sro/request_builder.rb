module Correios
  module SRO
    class RequestBuilder

      QUERY_TYPES =  { list: "L", range: "F" }.freeze

      RESULT_MODES = { all:  "T", last:  "U" }.freeze

      LANGUAGE = { pt:  "101", en:  "102" }.freeze

      NAMESPACES = {
        "xmlns:soapenv" => "http://schemas.xmlsoap.org/soap/envelope/",
        "xmlns:res" => "http://resource.webservice.correios.com.br/"
      }.freeze

      def initialize(tracker)
        @tracker = tracker
      end

      def build_xml
        Nokogiri::XML::Builder.new do |builder|
          builder[:soapenv].Envelope(NAMESPACES) {
            builder[:soapenv].Header  { }
            builder[:soapenv].Body  {
              builder[:res].buscaEventosLista() {
                builder.usuario(@tracker.user) {
                  builder.parent.namespace = nil
                }
                builder.senha(@tracker.password) {
                  builder.parent.namespace = nil
                }
                builder.tipo(QUERY_TYPES[@tracker.query_type]) {
                  builder.parent.namespace = nil
                }
                builder.resultado(RESULT_MODES[@tracker.result_mode]) {
                  builder.parent.namespace = nil
                }
                builder.lingua(LANGUAGE[@tracker.language]) {
                  builder.parent.namespace = nil
                }
                @tracker.object_numbers.each do |object_number|
                  builder.objetos(object_number) {
                    builder.parent.namespace = nil
                  }
                end
              }
            }
          }
        end.to_xml
      end


    end
  end
end
