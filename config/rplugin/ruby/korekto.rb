# frozen_string_literal: true

# KorektoPlug integrates the Korekto proof-checker with Neovim.
# The `:Korekto` command runs `korekto` on the current buffer, inserts
# validation tags (`#code [title]`) next to proven lines, and reports
# errors or the Korekto version in the message area.
class KorektoPlug
  VERSION = `korekto --version`.strip

  def initialize(nvim)
    @nvim = nvim
    @buf = nvim.get_current_buf
    @validations = `korekto < #{@buf.name}`.split("\n").map(&:strip)
    @msg = "Korekto! #{VERSION}"
    @filename = @line_number = @code = @title = nil # iteration variables
  end

  def set_error_msg
    @nvim.get_current_win.set_cursor([@line_number, 0]) if @filename == '-'
    @msg = "#{@filename}:#{@line_number}: #{@title}"
  end

  def edit_buffer
    line = @buf[@line_number].sub(/#.*$/, '').rstrip
    line << "\t##{@code}"
    line << " #{@title}" unless @title.empty?
    @buf[@line_number] = line unless line == @buf[@line_number]
  end

  def error?
    error = false
    if %w[? !].include?(@code)
      error = true
      set_error_msg
    elsif @filename == '-'
      edit_buffer
    end
    error
  end

  def run!
    while (validation = @validations.shift)
      @filename, @line_number, @code, @title = validation.split(':', 4)
      next unless (@line_number = @line_number.to_i).positive?
      break if error?
    end
    @nvim.command "echom #{@msg.inspect}"
  end
end

Neovim.plugin do |plug|
  plug.command(:Korekto) { |nvim| KorektoPlug.new(nvim).run! }
end
