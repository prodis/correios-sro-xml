require 'log-me'

module Correios
  module SRO
    extend LogMe
    extend Correios::SRO::Timeout
  end
end
