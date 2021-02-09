Neovim.plugin do |plug|
  plug.command(:Korekto) do |nvim|
    validations = nvim.command_output('w !korekto').strip.split("\n").map(&:strip)
    unless validations.empty?
      move,buf = true,nvim.get_current_buf
      while validation = validations.shift
        fields = validation.split(':',5)
        n = fields[1].to_i
        if n > 0
          fn,code,title = fields[0],fields[3],fields[4]
          if code=='?'
            nvim.get_current_win.set_cursor([n,0]) if fn=='-'
            nvim.command "echom '#{fn}: #{title}'"
          elsif fn=='-'
            line = buf[n].sub(/#.*$/,'').rstrip
            line << "\t##{code}"
            line << " #{title}" unless title==''
            buf[n] = line unless line == buf[n]
            # move onto first error:
            if move and code=='!'
              move = false
              nvim.get_current_win.set_cursor([n,0])
            end
          else
            nvim.command "echom '#{fn}: #{title}'"
          end
        end
      end
    end
  end
end
