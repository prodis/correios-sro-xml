require 'spec_helper'

describe Correios::SRO::RequestBuilder do

  describe ".build_xml" do

    let(:subject) { described_class.new(tracker).build_xml }

    context "given one tracking object" do
      let(:tracker) do
        sro = Correios::SRO::Tracker.new(user: "EXT", password: "APQ",
          query_type:   :list,
          result_mode:  :all
        )
        sro.instance_variable_set :@object_numbers, ["SS123456789BR"]
        sro
      end

      it { expect(subject).to include("<usuario>EXT</usuario>") }
      it { expect(subject).to include("<senha>APQ</senha>") }
      it { expect(subject).to include("<tipo>L</tipo>") }
      it { expect(subject).to include("<resultado>T</resultado>") }
      it { expect(subject).to include("<lingua>101</lingua>") }
      it { expect(subject).to include("<objetos>SS123456789BR</objetos>") }

    end

    context "given more than one tracking object" do
      let(:tracker) do
        sro = Correios::SRO::Tracker.new(user: "ECT", password: "SRO",
          language:     :en,
          query_type:   :range,
          result_mode:  :last
        )
        sro.instance_variable_set :@object_numbers, ["SS123456730BR", "SS12345650BR"]
        sro
      end

      it { expect(subject).to include("<usuario>ECT</usuario>") }
      it { expect(subject).to include("<senha>SRO</senha>") }
      it { expect(subject).to include("<tipo>F</tipo>") }
      it { expect(subject).to include("<resultado>U</resultado>") }
      it { expect(subject).to include("<lingua>102</lingua>") }
      it { expect(subject).to include("<objetos>SS123456730BR</objetos>") }
      it { expect(subject).to include("<objetos>SS12345650BR</objetos>") }

    end

  end

end
