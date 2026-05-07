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
    use { "catppuccin/nvim", as = "catppuccin" }
    use 'numToStr/Comment.nvim'
    use 'lewis6991/gitsigns.nvim'
    use 'sindrets/winshift.nvim'
    use "lukas-reineke/indent-blankline.nvim"
    use {
        'eric-furufors/git-conflict.nvim',
        tag = "*",
        config = function()
            require('git-conflict').setup({
                default_mappings = true,
                default_commands = true,
                disable_diagnostics = true,
            })
        end
    }
    use {
        'rmagatti/goto-preview',
        config = function()
            require('goto-preview').setup {
                default_mappings = false,
            }
        end
    }
    use 'derekwyatt/vim-fswitch'
end)
