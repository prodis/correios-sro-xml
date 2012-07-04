# encoding: UTF-8
require 'spec_helper'

describe Correios::SRO::WebService do
  describe "#request" do
    let(:tracker) { Correios::SRO::Tracker.new }
    let(:web_service) { Correios::SRO::WebService.new }

    it "returns XML response" do
      fake_request_for("<xml><fake></fake>")
      web_service.request(tracker).should == "<xml><fake></fake>"
    end
  end
end
