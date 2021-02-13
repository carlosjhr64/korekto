require 'korekto/symbols'
require 'korekto/syntax'
require 'korekto/statement_to_regexp'
require 'korekto/heap'
require 'korekto/statement'
require 'korekto/statements'
require 'korekto/main'

module Korekto
  VERSION = '0.0.210213'
  def Korekto.run = Korekto::Main.new.run
end
# Requires:
# `ruby`
