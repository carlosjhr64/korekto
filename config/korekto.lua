-- Minimal Neovim Config for Korekto

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { 'projekt0/github-nvim-theme',
      config = function()
	vim.cmd.colorscheme('github_light_high_contrast')
      end,
      version = '*' },
    { 'sheerun/vim-polyglot',
      version = '*' },
    { 'carlosjhr64/with-ruby',
      config = function()
	vim.g.VimMarkdownMetadataPlugins = 'navigation'
      end,
      version = '*' },
  },
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.conceallevel = 3
    vim.opt_local.foldlevel = 3
    vim.keymap.set('n', '<F9>', ':up<CR>:Korekto<CR>', { buffer = true })
  end,
})
