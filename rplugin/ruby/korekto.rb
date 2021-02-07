Neovim.plugin do |plug|
  plug.command(:Korekto) do |nvim|
    errors = nvim.command_output('w !korekto').strip.split("\n").map(&:strip)
    unless errors.empty?
      error = errors.shift.split(':',5)
      n = error[1].to_i
      if n > 0
        nvim.get_current_win.set_cursor([n,0])
        buf = nvim.get_current_buf
        line = buf.line.split('#',2).first.rstrip
        buf.line = line + " # #{error[3]}: #{error[4]}"
        while error = errors.shift
          error = error.split(':',5)
          n = error[1].to_i
          if n > 0
            line = buf[n].split('#',2).first.rstrip
            buf[n] = line + " # #{error[3]}: #{error[4]}"
          end
        end
      end
    end
  end
end
