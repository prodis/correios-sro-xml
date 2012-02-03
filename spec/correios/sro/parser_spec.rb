# encoding: UTF-8
require 'spec_helper'

describe Correios::SRO::Parser do
  describe "#objetos" do
    before :each do
      xml = body_for :success_response_many_objects
      parser = Correios::SRO::Parser.new
      @objetos = parser.objetos(xml)
    end

    ["SI047624825BR", "SX104110463BR"].each do |number|
      it "returns object number" do
        @objetos[number].numero.should == number
      end
    end

    context "returns event" do
      { "SI047624825BR" => {
          :tipo => "BDI",
          :status => "01",
          :data => "26/12/2011",
          :descricao => "Entregue",
          :recebedor => "",
          :documento => "",
          :comentario => "?",
          :local => "AC CENTRAL DE SAO PAULO",
          :codigo => "01009972",
          :cidade => "SAO PAULO",
          :uf => "SP",
          :sto => "00024419"
        },
        "SX104110463BR" => {
          :tipo => "BDE",
          :status => "01",
          :data => "08/12/2011",
          :descricao => "Entregue",
          :recebedor => "",
          :documento => "",
          :comentario => "",
          :local => "CEE JUNDIAI",
          :codigo => "13211970",
          :cidade => "JUNDIAI",
          :uf => "SP",
          :sto => "74654209"
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
      { "SI047624825BR" => {
          :local => "CTE VILA MARIA",
          :codigo => "02170975",
          :cidade => "SAO PAULO",
          :bairro => "PQ NOVO MUNDO",
          :uf => "SP"
        },
        "SX104110463BR" => {
          :local => "CTE CAMPINAS",
          :codigo => "13050971",
          :cidade => "VALINHOS",
          :bairro => "MACUCO",
          :uf => "SP"
        },
      }.each do |number, destination|
        destination.each do |attr, value|
          it attr do
            destino = @objetos[number].eventos[3].destino
            destino.send(attr).should == value
          end
        end
      end
    end
  end
end
