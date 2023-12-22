module Korekto
  VERSION = '1.6.231222'
  class Error < Exception; end

  def self.run
    require 'korekto/symbols'
    require 'korekto/syntax'
    require 'korekto/heap'
    require 'korekto/statement'
    require 'korekto/statements'
    require 'korekto/main'
    Korekto::Main.new.run
  end
end

# Requires:
# `ruby`
# `nvim`
# `neovim-ruby-host`
# `xdg-open`
