# encoding: UTF-8
require 'spec_helper'

describe Correios::SRO::WebService do
  describe "#request" do
    let(:sro) { Correios::SRO::Rastreador.new }
    let(:web_service) { Correios::SRO::WebService.new }

    it "encodes from ISO-8859-1 to UTF-8" do
      response = double("response", :body => "<xml><fake></fake>")
      response.body.should_receive(:backward_encode).with("UTF-8", "ISO-8859-1")
      Net::HTTP.stub(:post_form).and_return(response)
      web_service.request(sro)
    end

    it "returns XML response" do
      fake_request_for("<xml><fake></fake>")
      web_service.request(sro).should == "<xml><fake></fake>"
    end
  end
end
