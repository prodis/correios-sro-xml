require 'log-me'

module Correios
  module SRO
    extend LogMe
    extend Correios::SRO::AccessData
    extend Correios::SRO::Timeout
  end
end
