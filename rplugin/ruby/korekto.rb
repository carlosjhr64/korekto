Neovim.plugin do |plug|
  plug.command(:Korekto) do |nvim|
    validations = nvim.command_output('w !korekto').strip.split("\n").map(&:strip)
    unless validations.empty?
      move,buf = true,nvim.get_current_buf
      while validation = validations.shift
        fields = validation.split(':',5)
        n = fields[1].to_i
        if n > 0
          fn,status,msg = fields[0],fields[3],fields[4]
          if status=='?'
            nvim.get_current_win.set_cursor([n,0]) if fn=='-'
            nvim.command "echom '#{fn}: #{msg}'"
          elsif fn=='-'
            line = buf[n].sub(/#.*$/,'').rstrip
            line << "\t#"
            unless status.empty?
              line << status
              if move # to first error
                move = false
                nvim.get_current_win.set_cursor([n,0])
              end
            end
            line << ' '
            line << msg
            buf[n] = line unless line == buf[n]
          else
            nvim.command "echom '#{fn}: #{msg}'"
          end
        end
      end
    end
  end
end
