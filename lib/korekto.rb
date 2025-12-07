# frozen_string_literal: true

# Korekto namespace
module Korekto
  class Error < RuntimeError; end

  VERSION = '4.0.251207'

  class << self
    attr_writer :trace, :scrape
    attr_accessor :heap

    def trace? = @trace
    def scrape? = @scrape
  end
  Korekto.trace = false
  Korekto.heap = 60
  Korekto.scrape = false

  def self.run
    require 'English'
    require_relative 'korekto/refinements'
    require_relative 'korekto/symbols'
    require_relative 'korekto/syntax'
    require_relative 'korekto/handwaves'
    require_relative 'korekto/heap'
    require_relative 'korekto/statement'
    require_relative 'korekto/statements'
    require_relative 'korekto/main'
    Korekto::Main.new.run
  end
end

# Requires:
# `ruby`
# `nvim`
# `neovim-ruby-host`
