Gem::Specification.new do |s|

  s.name     = 'korekto'
  s.version  = '1.6.210407'

  s.homepage = 'https://github.com/carlosjhr64/korekto'

  s.author   = 'carlosjhr64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2021-04-07'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
A general proof checker.

Works with neovim(nvim).
DESCRIPTION

  s.summary = <<SUMMARY
A general proof checker.
SUMMARY

  s.require_paths = ['lib']
  s.files = %w(
bin/korekto
lib/korekto.rb
lib/korekto/heap.rb
lib/korekto/main.rb
lib/korekto/statement.rb
lib/korekto/statements.rb
lib/korekto/symbols.rb
lib/korekto/syntax.rb
rplugin/ruby/korekto.rb
start/korekto/ftdetect/korekto.vim
start/korekto/syntax/korekto.vim
  )
  s.executables << 'korekto'
  s.add_runtime_dependency 'help_parser', '~> 7.0', '>= 7.0.200907'
  s.requirements << 'ruby: ruby 3.0.1p64 (2021-04-05 revision 0fb782ee38) [x86_64-linux]'
  s.requirements << 'nvim: NVIM v0.4.4'
  s.requirements << 'xdg-open: xdg-open 1.1.3+'

end
