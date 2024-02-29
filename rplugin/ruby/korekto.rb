module KorektoPlug
  KOREKTO = `which korekto`.strip
  VERSION = `#{KOREKTO} --version`.strip

  def self.korekto(nvim)
    validations = nvim.command_output("w !#{KOREKTO}")
                  .strip.split("\n").map(&:strip)
    msg = "Korekto! #{VERSION}"
    unless validations.empty?
      buf = nvim.get_current_buf
      while (validation = validations.shift)
        fields = validation.split(':',4)
        n = fields[1].to_i
        next unless n.positive?
        fn,ln,code,title = fields
        if %w[? !].include?(code)
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
    nvim.command "echom #{msg.inspect}"
  end

  Neovim.plugin do |plug|
    plug.command(:Korekto){|nvim| KorektoPlug.korekto(nvim)}
  end
end
