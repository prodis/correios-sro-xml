# encoding: UTF-8
require 'spec_helper'

describe Correios::SRO::WebService do
  describe "#request" do
    around do |example|
      Correios::SRO.configure { |config| config.log_enabled = false }
      example.run
      Correios::SRO.configure { |config| config.log_enabled = true }
    end

    let(:tracker) { Correios::SRO::Tracker.new }
    let(:web_service) { Correios::SRO::WebService.new(tracker) }

    it "returns XML response" do
      mock_request_for("<xml><fake></fake>")
      web_service.request!.should eql "<xml><fake></fake>"
    end
  end
end
