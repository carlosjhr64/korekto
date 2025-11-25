Gem::Specification.new do |s|
  ## INFO ##
  s.name     = 'korekto'
  s.version  = '3.0.251125'
  s.homepage = 'https://github.com/carlosjhr64/korekto'
  s.author   = 'CarlosJHR64'
  s.email    = 'carlosjhr64@gmail.com'
  s.date     = '2024-03-05'
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
  s.add_runtime_dependency 'help_parser', '~> 8.2', '>= 8.2.230210'
  s.add_development_dependency 'colorize', '~> 1.1', '>= 1.1.0'
  s.add_development_dependency 'cucumber', '~> 9.1', '>= 9.1.1'
  s.add_development_dependency 'parser', '~> 3.3', '>= 3.3.0'
  s.add_development_dependency 'rubocop', '~> 1.60', '>= 1.60.1'
  s.add_development_dependency 'test-unit', '~> 3.6', '>= 3.6.1'
  s.requirements << 'git: 2.30'
  s.requirements << 'neovim-ruby-host: 0.9'
  s.requirements << 'nvim: 0.9'
  s.requirements << 'ruby: 3.3'
  s.requirements << 'xdg-open: 1.1'
end
