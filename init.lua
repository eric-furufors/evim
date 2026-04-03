-- =====================
-- UNIVERSAL (no plugins needed)
-- =====================

-- 24-bit colour
vim.opt.termguicolors = true

-- Shada/memory
vim.opt.shada = "'100,<50,s10,h"

-- reduce log size
vim.lsp.log.set_level("error")

-- Leader
vim.g.mapleader = " "

-- Tabs and indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Whitespace characters
vim.opt.list = true
vim.opt.listchars = {
    tab = "→ ",
    trail = "·",
    eol = "↩",
    extends = "▶",
    precedes = "◀",
}

-- Relative numbers
vim.opt.relativenumber = true

-- Foldcolumn
vim.opt.foldcolumn = "auto"

-- Timing
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 10

-- Winbar
vim.opt.winbar = "%f %m"

-- Keymaps
local opts = { noremap = true, silent = true }

-- Diagnostics / LSP
vim.keymap.set('n', '<leader>ii', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>id', vim.lsp.buf.definition, { desc = 'Go to definition' })

-- Tabs
vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnew<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>tt', ':tabnew | terminal<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>tc', ':tabc<CR>', opts)

-- Window navigation
vim.api.nvim_set_keymap('n', '<leader>wh', '<C-w>h', opts)
vim.api.nvim_set_keymap('n', '<leader>wj', '<C-w>j', opts)
vim.api.nvim_set_keymap('n', '<leader>wk', '<C-w>k', opts)
vim.api.nvim_set_keymap('n', '<leader>wl', '<C-w>l', opts)
vim.api.nvim_set_keymap('n', '<leader>wH', '<C-w>H', opts)
vim.api.nvim_set_keymap('n', '<leader>wJ', '<C-w>J', opts)
vim.api.nvim_set_keymap('n', '<leader>wK', '<C-w>K', opts)
vim.api.nvim_set_keymap('n', '<leader>wL', '<C-w>L', opts)

-- Save/Quit
vim.keymap.set('n', '<leader>ww', ':w<CR>', opts)
vim.keymap.set('n', '<leader>wa', ':wa<CR>', opts)
vim.keymap.set('n', '<leader>qq', ':q<CR>', opts)
vim.keymap.set('n', '<leader>qa', function()
    vim.cmd('mks! s.nvim')
    vim.cmd('qa')
end, opts)

-- Splits
vim.keymap.set('n', 'ss', ':split<CR>', opts)
vim.keymap.set('n', 'sv', ':vsplit<CR>', opts)

-- Macros
vim.keymap.set('n', '<leader>mm', '@@')

-- LaTeX
vim.keymap.set("n", "<leader>ll", function()
    local file = vim.fn.expand("%")
    vim.cmd("write")
    vim.cmd("!pdflatex " .. file)
end, { desc = "Compile LaTeX" })

vim.keymap.set("n", "<leader>lw", function()
    local file = vim.fn.expand("%")
    vim.cmd("write")
    local output = vim.fn.system({"texcount", file})
    print(output)
end, { desc = "Word count LaTeX" })

-- Blackhole paste
vim.keymap.set('v', '<leader>p', '"_dP')

-- Disable F1 help
vim.api.nvim_set_keymap('', '<F1>', '<Nop>', opts)

-- Commands
vim.api.nvim_create_user_command('Rapport', function()
    local lines = {
        '\\documentclass[12pt, a4paper, oneside]{article}',
        '',
        '\\usepackage[utf8]{inputenc}',
        '\\usepackage[T1]{fontenc}',
        '\\usepackage[a4paper, margin=2cm]{geometry}',
        '',
        '\\usepackage[swedish]{babel}',
        '%\\usepackage[english]{babel}',
        '',
        '\\usepackage[style=authoryear, backend=biber]{biblatex}',
        '\\addbibresource{references.bib}',
        '',
        '\\usepackage{listings}',
        '%\\usepackage{graphicx}',
        '',
        '\\lstset{',
        'basicstyle=\\ttfamily\\bfseries,',
        'breakindent=0pt,',
        'breaklines=true',
        '}',
        '\\title{}',
        '\\author{}',
        '\\date{\\today}',
        '',
        '\\begin{document}',
        '\\maketitle',
        '',
        '',
        '\\end{document}',
    }
    vim.api.nvim_put(lines, 'l', true, true)
end, {})

vim.api.nvim_create_user_command('BF', function()
    local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
    local lines = {
        '\\begin{lstlisting}[basicstyle=\\bfseries]',
        '',
        '\\end{lstlisting}'
    }
    vim.api.nvim_buf_set_lines(0, row, row, true, lines)
    vim.api.nvim_win_set_cursor(0, {row + 2, 0})
end, {})

vim.api.nvim_create_user_command('BILD', function()
    local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
    local lines = {
        '\\begin{figure}[h]',
        '\\centering',
        '\\includegraphics[width=0.6\\textwidth]{bilder/kursbok.jpg}',
        '\\caption{Kursboks tabell}',
        '\\label{fig:kursbok}',
        '\\end{figure}'
    }
    vim.api.nvim_buf_set_lines(0, row, row, true, lines)
    vim.api.nvim_win_set_cursor(0, {row + 3, 0})
end, {})

vim.api.nvim_create_user_command('Clean', function(o)
    vim.cmd(string.format('%d,%dg/^$/d', o.line1, o.line2))
end, { range = true })


-- =====================
-- PLUGINS
-- =====================

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'nvim-tree/nvim-web-devicons'
    use 'stevearc/oil.nvim'
    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use 'tpope/vim-fugitive'
    use { 'isak102/telescope-git-file-history.nvim', requires = { 'tpope/vim-fugitive', 'nvim-telescope/telescope.nvim' } }
    use 'nvim-lualine/lualine.nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'bluz71/vim-moonfly-colors'
    use 'numToStr/Comment.nvim'
    use { 'akinsho/git-conflict.nvim', tag = "*" }
    use 'lewis6991/gitsigns.nvim'
    use "sindrets/winshift.nvim"
end)

-- =====================
-- PLUGIN SETUP
-- =====================

-- OIL SETUP FIRST (To avoid "nil value" errors)
require('oil').setup({
    default_file_explorer = true,
    columns = { "icon" },
    view_options = { show_hidden = false },
})

require('mason').setup()
require('mason-lspconfig').setup()

-- LSP (Fixed for 0.11+)
if vim.lsp.config then
    vim.lsp.config('lua_ls', {})
    vim.lsp.config('clangd', {})
else
    -- Fallback for older versions
    require('lspconfig').lua_ls.setup{}
    require('lspconfig').clangd.setup{}
end

require('cmp').setup({
    mapping = require('cmp').mapping.preset.insert({
        ['<C-Space>'] = require('cmp').mapping.complete(),
        ['<CR>'] = require('cmp').mapping.confirm({ select = true }),
    }),
    sources = { { name = 'nvim_lsp' } },
})

require('lualine').setup({ options = { globalstatus = true } })

require('nvim-treesitter.configs').setup({
    ensure_installed = { "lua", "python", "c", "cpp" },
    highlight = { enable = true },
})

require('Comment').setup()
require('git-conflict').setup()
require('gitsigns').setup()
require('winshift').setup()

-- Theme
vim.cmd [[colorscheme moonfly]]
vim.opt.cursorline = true

-- Keymaps
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Live Grep' })
vim.keymap.set('n', '<leader>fa', '<cmd>Telescope<cr>', { desc = 'All Telescope commands' })
vim.keymap.set('n', '<leader>bb', '<cmd>Gitsigns toggle_current_line_blame<cr>', { desc = 'Toggle git blame' })
vim.keymap.set('n', '<leader>bh', '<cmd>Telescope git_file_history<cr>', { desc = 'Git file history' })

-- Oil Autostart (Simple & Direct)
if vim.fn.argc() == 0 then
    vim.defer_fn(function()
        require("oil").open()
    end, 1)
end
