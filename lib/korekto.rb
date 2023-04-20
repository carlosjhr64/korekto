module Korekto
  VERSION = '1.6.210409'
  class Error < Exception; end
  require 'korekto/symbols'
  require 'korekto/syntax'
  require 'korekto/heap'
  require 'korekto/statement'
  require 'korekto/statements'
  require 'korekto/main'
  def self.run = Korekto::Main.new.run
end
# Requires:
# `ruby`
# `nvim`
# `neovim-ruby-host`
# `xdg-open`
