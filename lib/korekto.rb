module Korekto
  class Error < Exception; end

  VERSION = '1.6.231223'

  def self.edits=(value)
    @@edits = value
  end

  Korekto.edits = false

  def self.edits?
    @@edits
  end

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
