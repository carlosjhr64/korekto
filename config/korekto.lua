-- Initializations
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Margin
vim.keymap.set('n', "<leader>m",
                    ":setlocal colorcolumn=80<CR>",
                    { noremap = true })
vim.keymap.set('n', "<leader>M",
                    ":setlocal colorcolumn=<CR>",
                    { noremap = true })

-- Add plugins
vim.pack.add({
  "https://github.com/projekt0n/github-nvim-theme",
  "https://github.com/folke/paint.nvim",
  "https://github.com/carlosjhr64/with-ruby",
})

-- Github theme
vim.cmd.colorscheme("github_light_high_contrast")

-- Highlights for Korekto
require("paint").setup({
  highlights = {
    { filter = { filetype = "markdown" }, pattern = "^[?~!<] .*$", hl = "PreProc",},
    { filter = { filetype = "markdown" }, pattern = ":[A-Za-z0-9_]+", hl = "Function",},
    { filter = { filetype = "markdown" }, pattern = "^[A-Za-z]*: ", hl = "Constant",},
    -- To avoid highlight conflict with Markdown  headers, comment Korecto with "#>"
    { filter = { filetype = "markdown" }, pattern = "^ *#>.*$", hl = "Comment",},
    { filter = { filetype = "markdown" }, pattern = "#[A-Z].*$", hl = "String",},
  },
})

-- With-Ruby builtin plugins: "vimwiki" navigation, folding
vim.g.VimMarkdownMetadataPlugins = "navigation fold"

-- Markdown conceal and fold level, and <F9> mapped to running Korekto.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.conceallevel = 3
    vim.opt_local.foldlevel = 1
    vim.keymap.set('n', "<F9>", ":up<CR>:Korekto<CR>", { buffer = true })
  end,
})
