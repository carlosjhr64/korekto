Gem::Specification.new do |s|
  ## INFO ##
  s.name     = 'korekto'
  s.version  = '4.0.251202'
  s.homepage = 'https://github.com/carlosjhr64/korekto'
  s.author   = 'CarlosJHR64'
  s.email    = 'carlosjhr64@gmail.com'
  s.date     = '2025-11-25'
  s.licenses = ['MIT']
  ## DESCRIPTION ##
  s.summary  = <<~SUMMARY
    A general proof checker.
  SUMMARY
  s.description = <<~DESCRIPTION
    A general proof checker.
    
    Works with [neovim](https://github.com/neovim/neovim).
  DESCRIPTION
  ## FILES ##
  s.require_paths = ['lib']
  s.files = %w[
    CREDITS.md
    README.md
    bin/korekto
    lib/korekto.rb
    lib/korekto/handwaves.rb
    lib/korekto/heap.rb
    lib/korekto/main.rb
    lib/korekto/refinements.rb
    lib/korekto/statement.rb
    lib/korekto/statements.rb
    lib/korekto/symbols.rb
    lib/korekto/syntax.rb
    rplugin/ruby/korekto.rb
    start/korekto/ftdetect/korekto.vim
    start/korekto/syntax/korekto.vim
  ]
    s.executables << 'korekto'
  ## REQUIREMENTS ##
  s.add_runtime_dependency 'fileutils', '~> 1.8', '>= 1.8.0'
  s.add_runtime_dependency 'help_parser', '~> 9.0', '>= 9.0.240926'
  s.requirements << 'neovim-ruby-host: 0.10'
  s.requirements << 'nvim: 0.11'
  s.required_ruby_version = '>= 4.0'
  s.requirements << 'which: 2016'
  s.requirements << 'xdg-open: 1.1'
end
