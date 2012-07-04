# encoding: UTF-8
require 'spec_helper'

describe Correios::SRO::Parser do
  describe "#objects" do
    let(:xml) { body_for :success_response_many_objects }
    let(:parser) { Correios::SRO::Parser.new }

    it "encodes from ISO-8859-1 to UTF-8" do
      xml.should_receive(:backward_encode).with("UTF-8", "ISO-8859-1").and_return(xml)
      parser.objects(xml)
    end

    ["SI047624825BR", "SX104110463BR"].each do |number|
      it "returns object number" do
        objects = parser.objects(xml)
        objects[number].number.should == number
      end
    end

    context "returns event" do
      before(:each) { @objects = parser.objects(xml) }

      { "SI047624825BR" => {
          :type => "BDI",
          :status => "01",
          :date => "26/12/2011",
          :hour => "15:22",
          :description => "Entregue",
          :receiver => "",
          :document => "",
          :comment => "?",
          :place => "AC CENTRAL DE SAO PAULO",
          :code => "01009972",
          :city => "SAO PAULO",
          :state => "SP",
          :sto => "00024419"
        },
        "SX104110463BR" => {
          :type => "BDE",
          :status => "01",
          :date => "08/12/2011",
          :hour => "09:30",
          :description => "Entregue",
          :receiver => "",
          :document => "",
          :comment => "",
          :place => "CEE JUNDIAI",
          :code => "13211970",
          :city => "JUNDIAI",
          :state => "SP",
          :sto => "74654209"
        },
      }.each do |number, first_event|
        first_event.each do |attr, value|
          it attr do
            event = @objects[number].events.first
            event.send(attr).should == value
          end
        end
      end
    end

    context "returns destination" do
      before(:each) { @objects = parser.objects(xml) }

      { "SI047624825BR" => {
          :place => "CTE VILA MARIA",
          :code => "02170975",
          :city => "SAO PAULO",
          :neighborhood => "PQ NOVO MUNDO",
          :state => "SP"
        },
        "SX104110463BR" => {
          :place => "CTE CAMPINAS",
          :code => "13050971",
          :city => "VALINHOS",
          :neighborhood => "MACUCO",
          :state => "SP"
        },
      }.each do |number, destinations|
        destinations.each do |attr, value|
          it attr do
            destination = @objects[number].events[3].destination
            destination.send(attr).should == value
          end
        end
      end
    end
  end
end
