# frozen_string_literal: true

# Korekto namespace
module Korekto
  class Error < RuntimeError; end

  VERSION = '4.0.251219'

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
    require_relative 'korekto/requires'
    Korekto::Main.new.run
  end
end

# Requires:
# `ruby`
# `nvim`
# `neovim-ruby-host`
