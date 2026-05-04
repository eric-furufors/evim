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
require('options')
require('plugins')
require('keymaps')
require('lsp')
require('ui')
require('tools')
