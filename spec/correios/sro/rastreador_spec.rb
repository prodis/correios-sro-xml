# encoding: UTF-8
require 'spec_helper'

describe Correios::SRO::Rastreador do
  describe ".new" do
    context "creates with default value of" do
      before(:each) { @sro = Correios::SRO::Rastreador.new }

      { :tipo => :lista, :resultado => :ultimo }.each do |attr, value|
        it attr do
          @sro.send(attr).should == value
        end
      end
    end

    { :usuario => "USUARIO",
      :senha => "SENHA",
      :tipo => :intervalo,
      :resultado => :todos
    }.each do |attr, value|
      context "when #{attr} is supplied" do
        it "sets #{attr}" do
          sro = Correios::SRO::Rastreador.new(attr => value)
          sro.send(attr).should == value
        end
      end

      context "when #{attr} is supplied in a block" do
        it "sets #{attr}" do
          sro = Correios::SRO::Rastreador.new { |f| f.send("#{attr}=", value) }
          sro.send(attr).should == value
        end
      end
    end
  end

  describe "#consultar" do
  end
end

