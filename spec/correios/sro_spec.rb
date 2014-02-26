require 'spec_helper'

describe Correios::SRO do
  context "timeout" do
    describe "#request_timeout" do
      it "default is 5" do
        expect(Correios::SRO.request_timeout).to eql 5
      end

      context "when set timeout" do
        it "returns timeout" do
          Correios::SRO.configure { |config| config.request_timeout = 3 }
          expect(Correios::SRO.request_timeout).to eql 3
        end

        it "returns timeout in seconds (integer)" do
          Correios::SRO.configure { |config| config.request_timeout = 2.123 }
          expect(Correios::SRO.request_timeout).to eql 2
        end
      end
    end
  end

  context "access data" do
    describe "#user" do
      it "returns configured user" do
        Correios::SRO.configure { |config| config.user = "PRODIS" }
        expect(Correios::SRO.user).to eql "PRODIS"
      end
    end

    describe "#password" do
      it "returns configured password" do
        Correios::SRO.configure { |config| config.password = "pim321" }
        expect(Correios::SRO.password).to eql "pim321"
      end
    end
  end
end
