Neovim.plugin do |plug|
  plug.command(:Korekto) do |nvim|
    validations = nvim.command_output('w !korekto').strip.split("\n").map(&:strip)
    unless validations.empty?
      buf = nvim.get_current_buf
      while validation = validations.shift
        validation = validation.split(':',6)
        n = validation[1].to_i
        if n > 0
          line = buf[n].split('#',2).first.rstrip
          line << "\t#"
          line << validation[3] unless validation[3].empty?
          line << ' '
          line << validation[4]
          unless validation[5].empty?
            line << ': '
            line << validation[5]
          end
          buf[n] = line
        end
      end
    end
  end
end
