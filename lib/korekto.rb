module Korekto
  VERSION = '1.3.210316'
  class Error < Exception; end
  require 'korekto/symbols'
  require 'korekto/syntax'
  require 'korekto/heap'
  require 'korekto/statement'
  require 'korekto/statements'
  require 'korekto/main'
  def Korekto.run = Korekto::Main.new.run
end
# Requires:
# `ruby`
# `nvim`
# `xdg-open`
