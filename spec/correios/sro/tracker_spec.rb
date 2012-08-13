# encoding: UTF-8
require 'spec_helper'

describe Correios::SRO::Tracker do
  describe ".new" do
    it "creates with default values" do
      sro = Correios::SRO::Tracker.new
      sro.result_type.should == :list
      sro.result_mode.should == :last
      sro.object_numbers.should == []
    end

    { :user => "PRODIS",
      :password => "pim321",
      :result_type => :interval,
      :result_mode => :all
    }.each do |attr, value|
      context "when #{attr} is supplied" do
        it "sets #{attr}" do
          sro = Correios::SRO::Tracker.new(attr => value)
          sro.send(attr).should == value
        end
      end

      context "when #{attr} is supplied in a block" do
        it "sets #{attr}" do
          sro = Correios::SRO::Tracker.new { |t| t.send("#{attr}=", value) }
          sro.send(attr).should == value
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

    let(:sro) { Correios::SRO::Tracker.new(:user => "PRODIS", :password => "pim321") }

    context "to many objects" do
      before(:each) { mock_request_for(:success_response_many_objects) }

      it "sets objects numbers" do
        sro.get("SI047624825BR", "SX104110463BR")
        sro.object_numbers.size.should == 2
        sro.object_numbers.first.should == "SI047624825BR"
        sro.object_numbers.last.should == "SX104110463BR"
      end

      it "creates a WebService with correct params" do
        web_service = Correios::SRO::WebService.new(sro)
        Correios::SRO::WebService.should_receive(:new).with(sro).and_return(web_service)
        sro.get("SI047624825BR", "SX104110463BR")
      end

      it "returns all objects" do
        objects = sro.get("SI047624825BR", "SX104110463BR")
        objects.size.should == 2
        objects["SI047624825BR"].number.should == "SI047624825BR"
        objects["SX104110463BR"].number.should == "SX104110463BR"
      end

      context "when only one object found" do
        before(:each) { mock_request_for(:success_response_one_object) }

        it "returns a Hash" do
          objects = sro.get("SI047624825BR", "SX104110463BR")
          objects.should be_an_instance_of Hash
        end

        it "returns the object found" do
          objects = sro.get("SI047624825BR", "SX104110463BR")
          objects.size.should == 1
          objects["SI047624825BR"].number.should == "SI047624825BR"
        end

        it "returns nil in object not found" do
          objects = sro.get("SI047624825BR", "SX104110463BR")
          objects["SX104110463BR"].should be_nil
        end
      end
    end

    context "to one object" do
      before(:each) { mock_request_for(:success_response_one_object) }

      it "sets object number" do
        sro.get("SI047624825BR")
        sro.object_numbers.size.should == 1
        sro.object_numbers.first.should == "SI047624825BR"
      end

      it "creates a WebService with correct params" do
        web_service = Correios::SRO::WebService.new(sro)
        Correios::SRO::WebService.should_receive(:new).with(sro).and_return(web_service)
        sro.get("SI047624825BR")
      end

      it "returns only one object" do
        object = sro.get("SI047624825BR")
        object.number.should == "SI047624825BR"
      end

      context "when object not found" do
        it "returns nil" do
          mock_request_for(:failure_response_not_found)
          object = sro.get("SI047624825BR")
          object.should be_nil
        end
      end
    end
  end
end
