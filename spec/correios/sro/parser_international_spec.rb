# encoding: UTF-8
require 'spec_helper'

describe Correios::SRO::Parser do
  describe "#objeto" do
    before :each do
      xml = body_for :success_international
      parser = Correios::SRO::Parser.new
      @objetos = parser.objetos(xml)
    end

      it "returns object number" do
        number = "EC688801478US"
        @objetos[number].numero.should == number
    end

    context "returns event" do
      { "EC688801478US" => {
          :tipo => "RO",
          :status => "01",
          :data => "09/04/2012",
          :hora => "13:32",
          :descricao => "Encaminhado",
          :local => "UNIDADE TRAT INTERNACIONAL SAO PAULO",
          :codigo => "05314980",
          :cidade => "SAO PAULO",
          :uf => "SP",
          :sto => "99999999"
        },
      }.each do |number, first_event|
        first_event.each do |attr, value|
          it attr do
            evento = @objetos[number].eventos.first
            evento.send(attr).should == value
          end
        end
      end
    end

    context "returns destination" do
      { "EC688801478US" => {
          :local => "RFB - FISCALIZAÇÃO/CUSTOMS",
          :codigo => "00002999",
          :cidade => nil,
          :bairro => nil,
          :uf => nil
        },
      }.each do |number, destination|
        destination.each do |attr, value|
          it attr do
            destino = @objetos[number].eventos.first.destino
            destino.send(attr).should == value
          end
        end
      end
    end
  end
end
