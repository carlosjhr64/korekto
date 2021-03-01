Neovim.plugin do |plug|
  plug.command(:Korekto) do |nvim|
    validations = nvim.command_output('w !korekto').strip.split("\n").map(&:strip)
    msg = 'OK'
    unless validations.empty?
      buf = nvim.get_current_buf
      while validation = validations.shift
        fields = validation.split(':',4)
        n = fields[1].to_i
        if n > 0
          fn,ln,code,title = fields
          if code=='?' or code=='!'
            # move onto error if on page
            nvim.get_current_win.set_cursor([n,0]) if fn=='-'
            # echo error message
            msg = "#{fn}:#{ln}: #{title}"
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
    nvim.command "echom #{msg.inspect}"
  end
end
