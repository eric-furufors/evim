vim.opt.termguicolors = true
vim.opt.shada = "'100,<50,s10,h"
vim.lsp.log.set_level("error")
vim.g.mapleader = " "

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.list = true
vim.opt.listchars = {
    tab = "→ ",
    trail = "·",
    eol = "¬",
    extends = "▶",
    precedes = "◀",
}

vim.opt.relativenumber = true
vim.opt.foldcolumn = "auto"
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 10
vim.opt.cursorline = true
vim.opt.winbar = nil
