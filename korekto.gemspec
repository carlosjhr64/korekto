Gem::Specification.new do |s|
  ## INFO ##
  s.name     = 'korekto'
  s.version  = '4.0.260110'
  s.homepage = 'https://github.com/carlosjhr64/korekto'
  s.author   = 'CarlosJHR64'
  s.email    = 'carlosjhr64@gmail.com'
  s.date     = '2026-01-11'
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
    config/korekto.lua
    config/rplugin/ruby/korekto.rb
    config/syntax/korekto.vim
    examples/ABC.md
    examples/Computation.md
    examples/Dxx.md
    examples/Neuronet.md
    examples/Sqrt2.md
    examples/Squash.md
    examples/Tutorial.md
    examples/TwoCube.md
    examples/index.md
    imports/Algebra.md
    imports/Calculus.md
    imports/Integer.md
    imports/KorektoMath.md
    imports/Logic.md
    imports/Natural.md
    imports/Rational.md
    imports/Real.md
    imports/Syntax.md
    lib/korekto.rb
    lib/korekto/context_search.rb
    lib/korekto/handwaves.rb
    lib/korekto/heap.rb
    lib/korekto/main.rb
    lib/korekto/refinements.rb
    lib/korekto/requires.rb
    lib/korekto/statement.rb
    lib/korekto/statement_handlers.rb
    lib/korekto/statement_struct.rb
    lib/korekto/statements.rb
    lib/korekto/symbols.rb
    lib/korekto/syntax.rb
  ]
    s.executables << 'korekto'
  ## REQUIREMENTS ##
  s.add_runtime_dependency 'help_parser', '~> 9.0', '>= 9.0.240926'
  s.requirements << 'neovim-ruby-host: 0.10'
  s.requirements << 'nvim: 0.12'
  s.required_ruby_version = '>= 4.0'
end
