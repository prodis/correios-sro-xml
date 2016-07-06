require 'spec_helper'

describe Correios::SRO::Parser do
  describe "#objects" do
    let(:xml) { Fixture.load :sro_many_objects }

    ["SI047624825BR", "SX104110463BR"].each do |number|
      it "returns object number" do
        objects = subject.objects(xml)
        expect(objects[number].number).to eql number
      end
    end

    context "returns event" do
      before { @objects = subject.objects(xml) }

      { "SI047624825BR" => {
          type: "BDI",
          status: "01",
          date: "26/12/2016",
          hour: "15:22",
          description: "Objeto entregue ao destinatário",
          receiver: "?",
          document: "?",
          comment: "?",
          place: "AC CENTRAL DE SAO PAULO",
          code: "01009972",
          city: "SAO PAULO",
          state: "SP",
          sto: "00024419"
        },
        "SX104110463BR" => {
          type: "BDE",
          status: "01",
          date: "26/12/2016",
          hour: "15:22",
          description: "Objeto entregue ao destinatário",
          receiver: nil,
          document: nil,
          comment: nil,
          place: "AC CENTRAL DE SAO PAULO",
          code: "01009972",
          city: "SAO PAULO",
          state: "SP",
          sto: "74654209"
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
      before { @objects = subject.objects(xml) }

      { "SI047624825BR" => {
          place: "CTE VILA MARIA",
          code: "02170975",
          city: "Sao Paulo",
          neighborhood: "PQ NOVO MUNDO",
          state: "SP"
        },
        "SX104110463BR" => {
          place: "CTE CAMPINAS",
          code: "13050971",
          city: "VALINHOS",
          neighborhood: "MACUCO",
          state: "SP"
        },
      }.each do |number, destinations|
        destinations.each do |attr, value|
          it attr do
            destination = @objects[number].events[3].destination
            expect(destination.send(attr)).to eql value
          end
        end
      end
    end
  end
end
