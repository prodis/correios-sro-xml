require 'spec_helper'

describe Correios::SRO::WebService do
  describe "#request" do
    let(:object_number) { "SS123456789BR" }

    around do |example|
      Correios::SRO.configure { |config| config.log_enabled = false }
      example.run
      Correios::SRO.configure { |config| config.log_enabled = true }
    end

    let(:tracker) do
      sro = Correios::SRO::Tracker.new(user: "ECT", password: "SRO")
      sro.instance_variable_set :@object_numbers, [object_number]
      sro
    end
    let(:subject) { Correios::SRO::WebService.new(tracker) }

    it "returns XML response", vcr: { cassette_name: "sro_found_last" } do
      expect(subject.request!).to include("<numero>#{object_number}</numero>")
    end
  end
end
