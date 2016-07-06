require 'spec_helper'

describe Correios::SRO::Tracker do

  describe ".new" do
    it "creates with default values" do
      expect(subject.query_type).to eql :list
      expect(subject.result_mode).to eql :last
      expect(subject.object_numbers).to eql []
    end

    context "when access data is supplied on configuration" do
      around do |example|
        Correios::SRO.configure do |config|
          config.user = "SROUSER"
          config.password = "1q2w3e"
        end

        example.run

        Correios::SRO.configure do |config|
          config.user = nil
          config.password = nil
        end
      end

      it "uses access data from configuration" do
        expect(subject.user).to eql "SROUSER"
        expect(subject.password).to eql "1q2w3e"
      end
    end

    { user: "PRODIS",
      password: "pim321",
      query_type: :range,
      result_mode: :all
    }.each do |attr, value|
      context "when #{attr} is supplied" do
        it "sets #{attr}" do
          sro = Correios::SRO::Tracker.new(attr => value)
          expect(sro.send(attr)).to eql value
        end
      end

      context "when #{attr} is supplied in a block" do
        it "sets #{attr}" do
          sro = Correios::SRO::Tracker.new { |t| t.send("#{attr}=", value) }
          expect(sro.send(attr)).to eql value
        end
      end
    end
  end

  describe "#get" do
    around do |example|
      Correios::SRO.configure { |config| config.log_enabled = false }
      example.run
      Correios::SRO.configure { |config| config.log_enabled = true }
    end

    let(:subject)  { Correios::SRO::Tracker.new(user: "PRODIS", password: "pim321") }

    before { Correios::SRO::WebService.any_instance.stub(:request!).and_return(response) }

    context "to many objects" do
      let(:response) { Fixture.load :sro_many_objects }

      it "accepts a list as argument" do
        objects = subject.get(["SI047624825BR", "SX104110463BR"])

        expect(objects.size).to eql 2
      end

      it "sets objects numbers" do
        subject.get("SI047624825BR", "SX104110463BR")

        expect(subject.object_numbers.size).to eql 2
        expect(subject.object_numbers.first).to eql "SI047624825BR"
        expect(subject.object_numbers.last).to eql "SX104110463BR"
      end

      it "returns all objects" do
        objects = subject.get("SI047624825BR", "SX104110463BR")

        expect(objects.size).to eql 2

        expect(objects["SI047624825BR"].number).to eql "SI047624825BR"
        expect(objects["SI047624825BR"].events.first.description).to eql "Objeto entregue ao destinatário"

        expect(objects["SX104110463BR"].number).to eql "SX104110463BR"
        expect(objects["SX104110463BR"].events.first.description).to eql "Objeto entregue ao destinatário"
      end

      context "when only one object found" do
        let(:response) { Fixture.load :sro_one_object }

        it "returns a Hash" do
          objects = subject.get("SI047624825BR", "SX104110463BR")
          expect(objects).to be_an_instance_of Hash
        end

        it "returns the object found" do
          objects = subject.get("SI047624825BR", "SX104110463BR")

          expect(objects.size).to eql 1
          expect(objects["SI047624825BR"].number).to eql "SI047624825BR"
          expect(objects["SI047624825BR"].events.first.description).to eql "Objeto entregue ao destinatário"
        end

        it "returns nil in object not found" do
          objects = subject.get("SI047624825BR", "SX104110463BR")
          expect(objects["SX104110463BR"]).to be_nil
        end
      end
    end

    context "to one object" do
      let(:response) { Fixture.load :sro_one_object }
      let(:object_number) { "SI047624825BR" }

      it "sets object number" do
        subject.get("SI047624825BR")
        expect(subject.object_numbers.size).to eql 1
        expect(subject.object_numbers.first).to eql "SI047624825BR"
      end

      it "returns only one object" do
        object = subject.get("SI047624825BR")
        expect(object.number).to eql "SI047624825BR"
        expect(object.events.first.description).to eql "Objeto entregue ao destinatário"
      end

      context "when object not found" do
        let(:response) { Fixture.load :sro_not_found }

        it "returns nil" do
          expect(subject.get("SI047624825BR")).to be_nil
        end
      end
    end
  end
end
