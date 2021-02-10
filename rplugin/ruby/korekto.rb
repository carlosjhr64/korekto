Neovim.plugin do |plug|
  plug.command(:Korekto) do |nvim|
    validations = nvim.command_output('w !korekto').strip.split("\n").map(&:strip)
    unless validations.empty?
      buf = nvim.get_current_buf
      while validation = validations.shift
        fields = validation.split(':',5)
        n = fields[1].to_i
        if n > 0
          fn,code,title = fields[0],fields[3],fields[4]
          if code=='?' or code=='!'
            # move onto error if on page
            nvim.get_current_win.set_cursor([n,0]) if fn=='-'
            # echo error message
            nvim.command "echom #{title.inspect}"
            # and stop.
            break
          elsif fn=='-'
            line = buf[n].sub(/#.*$/,'').rstrip
            line << "\t##{code}"
            line << " #{title}" unless title==''
            buf[n] = line unless line == buf[n]
          end
        end
      end
    end
  end
end
