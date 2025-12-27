# frozen_string_literal: true

# Korekto namespace
module Korekto
  # Error is rescued in Korekto::Main, where it puts the file name and
  # line number where the error occurred with its message, and
  # exits with code 65.
  # If otherwise should a StandardError occur, it's a bug, and Korekto::Main
  # will also rescue, but additionally give a backtrace and exit with code 1.
  class Error < RuntimeError; end

  VERSION = '4.0.251227'

  class << self
    # :reek:Attribute
    attr_writer :trace, :scrape, :warn
    # :reek:Attribute
    attr_accessor :heap

    def trace? = @trace
    def scrape? = @scrape
    def warn? = @warn
  end
  Korekto.trace = false
  Korekto.heap = 60
  Korekto.scrape = false
  Korekto.warn = false

  def self.run
    require_relative 'korekto/requires'
    Korekto::Main.new.run
  end
end

# Requires:
# `ruby`
# `nvim`
# `neovim-ruby-host`
