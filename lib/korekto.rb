module Korekto
  class Error < RuntimeError; end

  VERSION = '3.0.240228'

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
  Korekto.heap = 60

  def self.scrape?
    @@scrape
  end
  def self.scrape=(value)
    @@scrape = value
  end
  Korekto.scrape = false

  def self.run
    require 'korekto/refinements'
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
