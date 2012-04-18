# encoding: UTF-8
require 'spec_helper'

describe Correios::SRO::WebService do
  describe "#request" do
    let(:sro) { Correios::SRO::Rastreador.new }
    let(:web_service) { Correios::SRO::WebService.new }

    it "returns XML response" do
      fake_request_for("<xml><fake></fake>")
      web_service.request(sro).should == "<xml><fake></fake>"
    end
  end
end
