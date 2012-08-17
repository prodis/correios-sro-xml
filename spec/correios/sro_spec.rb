# encoding: UTF-8
require 'spec_helper'

describe Correios::SRO do
  describe "#request_timeout" do
    it "default is 5" do
      Correios::SRO.request_timeout.should eql 5
    end

    context "when set timeout" do
      it "returns timeout" do
        Correios::SRO.configure { |config| config.request_timeout = 3 }
        Correios::SRO.request_timeout.should eql 3
      end

      it "returns timeout in seconds (integer)" do
        Correios::SRO.configure { |config| config.request_timeout = 2.123 }
        Correios::SRO.request_timeout.should eql 2
      end
    end
  end
end
