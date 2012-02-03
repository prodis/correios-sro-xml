# encoding: UTF-8
require 'spec_helper'

describe Correios::SRO::Rastreador do
  describe ".new" do
    context "creates with default value of" do
      before(:each) { @sro = Correios::SRO::Rastreador.new }

      { :tipo => :lista,
        :resultado => :ultimo,
        :objetos => []
      }.each do |attr, value|
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
    before :each do
      fake_request_for :success_response_many_objects
      @sro = Correios::SRO::Rastreador.new :usuario => "USUARIO", :senha => "SENHA"
    end

    it "sets objetos" do
      @sro.consultar("SQ458226057B", "RA132678652BR")
      @sro.objetos.size.should == 2
      @sro.objetos.first.should == "SQ458226057B"
      @sro.objetos.last.should == "RA132678652BR"
    end
  end
end

