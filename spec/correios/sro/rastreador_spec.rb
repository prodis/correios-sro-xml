# encoding: UTF-8
require 'spec_helper'

describe Correios::SRO::Rastreador do
  describe ".new" do
    it "creates new tracker" do
      sro = Correios::SRO::Rastreador.new
      sro.should_not be_nil
    end
  end
end

