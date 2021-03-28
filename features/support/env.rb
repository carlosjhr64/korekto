ENV['PATH'] = ENV['PATH'].split(':').prepend('./bin').uniq.join(':')
