# encoding: UTF-8
require 'spec_helper'

describe Correios::SRO::Evento do
  let(:evento) { Correios::SRO::Evento.new }

  [:recebedor, :documento, :comentario].each do |method|
    describe "##{method}=" do
      it "strips string" do
        evento.send("#{method}=", "   Texto.   ")
        evento.send(method).should == "Texto."
      end
    end
  end
end
