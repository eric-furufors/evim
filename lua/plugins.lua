vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {

    { "nvim-lualine/lualine.nvim" },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "tpope/vim-fugitive",
            {
                "isak102/telescope-git-file-history.nvim",
                dependencies = { "tpope/vim-fugitive" },
            },
        },
    },

    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },

    { "tpope/vim-fugitive" },

    {
        "sindrets/winshift.nvim",
        opts = {},
    },

    {
        "akinsho/git-conflict.nvim",
        version = "*",
        opts = {
            default_mappings = true,
            default_commands = true,
            disable_diagnostics = true,
        },
    },

    {
        "rmagatti/goto-preview",
        opts = {
            default_mappings = false,
        },
    },

    { "derekwyatt/vim-fswitch" },

    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
    },

    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            enhanced_diff_hl = true,
            view = { default = { layout = "diff2_horizontal" } },
            keymaps = {
                view = {
                    { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
                },
                file_panel = {
                    { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
                },
                file_history_panel = {
                    { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
                },
            },
            hooks = {
                view_opened = function()
                    -- Dölj panelen direkt när vyn öppnas
                    vim.schedule(function() vim.cmd("DiffviewToggleFiles") end)
                end,
            },
        },
    },

}
