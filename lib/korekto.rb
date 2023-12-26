module Korekto
  class Error < Exception; end

  VERSION = '1.6.231226'

  def self.edits=(value)
    @@edits = value
  end
  def self.edits?
    @@edits
  end
  Korekto.edits = false

  def self.patch=(value)
    @@patch = value
  end
  def self.patch?
    @@patch
  end
  Korekto.patch = false

  def self.heap=(value)
    @@heap = value
  end
  def self.heap
    @@heap
  end
  Korekto.heap = 13

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
