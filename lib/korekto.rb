module Korekto
  class Error < Exception; end

  VERSION = '2.0.231227'

  def self.trace=(value)
    @@trace = value
  end
  def self.trace?
    @@trace
  end
  Korekto.trace = false

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
