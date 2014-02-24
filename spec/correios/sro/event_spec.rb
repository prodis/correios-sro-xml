require 'spec_helper'

describe Correios::SRO::Event do
  [:receiver, :document, :comment].each do |method|
    describe "##{method}=" do
      it "strips string" do
        subject.send("#{method}=", "   Texto.   ")
        expect(subject.send(method)).to eql "Texto."
      end
    end
  end
end
