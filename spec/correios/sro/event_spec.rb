# encoding: UTF-8
require 'spec_helper'

describe Correios::SRO::Event do
  let(:event) { Correios::SRO::Event.new }

  [:receiver, :document, :comment].each do |method|
    describe "##{method}=" do
      it "strips string" do
        event.send("#{method}=", "   Texto.   ")
        event.send(method).should == "Texto."
      end
    end
  end
end
