-- =========================================================
-- Entry point — controls load order, order matters:
--   options  must come first (sets leader before keymaps)
--   plugins  must come before lsp/ui/tools (loads the plugins)
--   keymaps  after plugins (some binds reference plugin functions)
--   lsp      after plugins (mason, cmp, lspconfig setup)
--   ui       after plugins (catppuccin, lualine, ibl setup)
--   tools    after plugins (oil, treesitter, gitsigns etc)
--
-- gf on any filename below to jump to it
-- Ctrl+w f   — open in horizontal split
-- Ctrl+w gf  — open in new tab
-- =========================================================
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "lsp" },
    { import = "ui" },
    { import = "tools" },
    { import = "plugins" },
  },
})

require("options")
require("keymaps")
