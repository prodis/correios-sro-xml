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

    before :each do
      mock_request_for :success_response_many_objects
      @sro = Correios::SRO::Tracker.new(:user => "PRODIS", :password => "pim321")
    end

    it "sets objects numbers" do
      @sro.get("SQ458226057B", "RA132678652BR")
      @sro.object_numbers.size.should == 2
      @sro.object_numbers.first.should == "SQ458226057B"
      @sro.object_numbers.last.should == "RA132678652BR"
    end
  end
end
